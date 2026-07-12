import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";
import { withFileMutationQueue } from "@mariozechner/pi-coding-agent";
import { createHash } from "node:crypto";
import { existsSync } from "node:fs";
import { readFile } from "node:fs/promises";
import { isAbsolute, resolve } from "node:path";
import { spawn } from "node:child_process";

const HOOK_COMMAND = process.env.PI_CLJ_PAREN_REPAIR_HOOK_CMD ?? "clj-paren-repair-claude-hook --cljfmt";
const HOOK_TIMEOUT_MS = Number(process.env.PI_CLJ_PAREN_REPAIR_HOOK_TIMEOUT_MS ?? "30000");

type HookEventName = "PreToolUse" | "PostToolUse" | "SessionEnd";
type HookToolName = "Write" | "Edit" | null;

type ToolResultContent = Array<{ type: string; text?: string; data?: string; mimeType?: string }>;

type HookResponse = {
	decision?: "block";
	reason?: string;
	hookSpecificOutput?: {
		hookEventName?: string;
		permissionDecision?: "deny";
		permissionDecisionReason?: string;
		additionalContext?: string;
	};
};

function parseHookOutput(text: string): HookResponse | null {
	const trimmed = text.trim();
	if (!trimmed) return null;

	try {
		return JSON.parse(trimmed) as HookResponse;
	} catch {}

	for (const line of trimmed.split("\n").reverse()) {
		const candidate = line.trim();
		if (!candidate.startsWith("{") || !candidate.endsWith("}")) continue;
		try {
			return JSON.parse(candidate) as HookResponse;
		} catch {}
	}

	return null;
}

function getSessionId(ctx: ExtensionContext): string {
	const sessionFile = ctx.sessionManager.getSessionFile();
	if (!sessionFile) return `pi-ephemeral-${process.pid}`;
	const shortHash = createHash("sha1").update(sessionFile).digest("hex").slice(0, 12);
	return `pi-${shortHash}`;
}

function isBlocked(response: HookResponse | null): { blocked: boolean; reason?: string } {
	if (!response) return { blocked: false };

	if (response.decision === "block") {
		return { blocked: true, reason: response.reason ?? "Blocked by clj-paren-repair hook" };
	}

	if (response.hookSpecificOutput?.permissionDecision === "deny") {
		return {
			blocked: true,
			reason: response.hookSpecificOutput.permissionDecisionReason ?? response.reason ?? "Denied by clj-paren-repair hook",
		};
	}

	return { blocked: false };
}

async function runHook(
	ctx: ExtensionContext,
	eventName: HookEventName,
	toolName: HookToolName,
	extra: Record<string, unknown>,
): Promise<HookResponse | null> {
	const payload = {
		hook_event_name: eventName,
		tool_name: toolName,
		session_id: getSessionId(ctx),
		...extra,
	};

	return new Promise((resolve, reject) => {
		const child = spawn("bash", ["-lc", HOOK_COMMAND], {
			cwd: ctx.cwd,
			stdio: ["pipe", "pipe", "pipe"],
		});

		let stdout = "";
		let stderr = "";
		let timedOut = false;

		const timeout = setTimeout(() => {
			timedOut = true;
			child.kill("SIGTERM");
		}, HOOK_TIMEOUT_MS);

		child.stdout.on("data", (chunk: Buffer | string) => {
			stdout += chunk.toString();
		});

		child.stderr.on("data", (chunk: Buffer | string) => {
			stderr += chunk.toString();
		});

		child.on("error", (error) => {
			clearTimeout(timeout);
			reject(error);
		});

		child.on("close", (code) => {
			clearTimeout(timeout);

			if (timedOut) {
				reject(new Error(`clj-paren-repair hook timed out after ${HOOK_TIMEOUT_MS}ms`));
				return;
			}

			if (code !== 0) {
				reject(new Error(`clj-paren-repair hook failed (exit ${code})${stderr ? `: ${stderr.trim()}` : ""}`));
				return;
			}

			resolve(parseHookOutput(stdout));
		});

		child.stdin.end(JSON.stringify(payload));
	});
}

function isClojurePath(path: string): boolean {
	return /\.(clj|cljs|cljc|cljd|bb|lpy|edn)$/i.test(path);
}

function toAbsolutePath(cwd: string, path: string): string {
	return isAbsolute(path) ? path : resolve(cwd, path);
}

function getString(value: unknown, key: string): string | undefined {
	if (!value || typeof value !== "object" || !(key in value)) return undefined;
	const candidate = (value as Record<string, unknown>)[key];
	return typeof candidate === "string" ? candidate : undefined;
}

function getStringArray(value: unknown, key: string): string[] {
	if (!value || typeof value !== "object" || !(key in value)) return [];
	const candidate = (value as Record<string, unknown>)[key];
	return Array.isArray(candidate) ? candidate.filter((item): item is string => typeof item === "string") : [];
}

function extractPatchPathsFromInput(input: unknown): string[] {
	const patchText = getString(input, "input");
	if (!patchText) return [];

	const paths: string[] = [];
	for (const line of patchText.split("\n")) {
		const match = line.match(/^\*\*\* (?:Add|Update|Delete) File: (.+)$/);
		if (match) paths.push(match[1].trim());
	}
	return paths;
}

function extractPatchPathsFromDetails(details: unknown): string[] {
	const result = details && typeof details === "object" && "result" in details ? (details as Record<string, unknown>).result : undefined;
	if (!result || typeof result !== "object") return [];

	return [
		...getStringArray(result, "changedFiles"),
		...getStringArray(result, "createdFiles"),
		...getStringArray(result, "movedFiles").map((move) => move.split(" -> ").at(-1) ?? move),
	];
}

function uniquePaths(paths: string[]): string[] {
	return Array.from(new Set(paths.filter((path) => path.length > 0)));
}

function getToolPaths(toolName: string, input: unknown, details: unknown): string[] {
	if (toolName === "write" || toolName === "edit") {
		const path = getString(input, "path") ?? getString(input, "file_path");
		return path ? [path] : [];
	}

	if (toolName === "apply_patch") {
		const pathsFromDetails = extractPatchPathsFromDetails(details);
		return pathsFromDetails.length > 0 ? pathsFromDetails : extractPatchPathsFromInput(input);
	}

	return [];
}

async function repairPath(ctx: ExtensionContext, path: string): Promise<{ path: string; changed: boolean; error?: string }> {
	const absolutePath = toAbsolutePath(ctx.cwd, path);
	if (!isClojurePath(absolutePath) || !existsSync(absolutePath)) return { path, changed: false };

	try {
		return await withFileMutationQueue(absolutePath, async () => {
			const before = await readFile(absolutePath, "utf8");
			const response = await runHook(ctx, "PostToolUse", "Edit", {
				tool_input: { file_path: absolutePath },
				tool_response: { success: true },
			});

			const block = isBlocked(response);
			if (block.blocked) return { path, changed: false, error: block.reason ?? "clj-paren-repair blocked the edit" };

			const after = await readFile(absolutePath, "utf8");
			return { path, changed: before !== after };
		});
	} catch (error) {
		return { path, changed: false, error: error instanceof Error ? error.message : String(error) };
	}
}

function formatChangedMessage(paths: string[]): string {
	if (paths.length === 1) {
		return `formatted ${paths[0]}; re-read it before further edits`;
	}

	return `formatted:\n${paths.map((path) => `- ${path}`).join("\n")}\nre-read them before further edits`;
}

function formatErrorMessage(errors: Array<{ path: string; error: string }>): string {
	if (errors.length === 1) {
		return `clj-paren-repair failed ${errors[0].path}: ${errors[0].error}`;
	}

	return `clj-paren-repair failed:\n${errors.map(({ path, error }) => `- ${path}: ${error}`).join("\n")}`;
}

export default function (pi: ExtensionAPI) {
	pi.on("tool_result", async (event, ctx) => {
		if (event.isError) return undefined;
		if (event.toolName !== "write" && event.toolName !== "edit" && event.toolName !== "apply_patch") return undefined;

		const paths = uniquePaths(getToolPaths(event.toolName, event.input, event.details));
		if (paths.length === 0) return undefined;

		const results = await Promise.all(paths.map((path) => repairPath(ctx, path)));
		const changedPaths = results.filter((result) => result.changed).map((result) => result.path);
		const errors = results.filter((result): result is { path: string; changed: boolean; error: string } => Boolean(result.error));

		if (changedPaths.length === 0 && errors.length === 0) return undefined;

		const content: ToolResultContent = [...event.content];
		if (changedPaths.length > 0) {
			content.push({ type: "text", text: formatChangedMessage(changedPaths) });
		}
		if (errors.length > 0) {
			content.push({ type: "text", text: formatErrorMessage(errors) });
		}

		return { content, isError: errors.length > 0 ? true : event.isError };
	});

	pi.on("session_shutdown", async (_event, ctx) => {
		await runHook(ctx, "SessionEnd", null, {});
	});
}
