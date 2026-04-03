import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";
import { createEditTool, createWriteTool } from "@mariozechner/pi-coding-agent";
import { createHash } from "node:crypto";
import { spawn } from "node:child_process";

const HOOK_COMMAND = process.env.PI_CLJ_PAREN_REPAIR_HOOK_CMD ?? "clj-paren-repair-claude-hook --cljfmt";
const HOOK_TIMEOUT_MS = Number(process.env.PI_CLJ_PAREN_REPAIR_HOOK_TIMEOUT_MS ?? "30000");

type HookEventName = "PreToolUse" | "PostToolUse" | "SessionEnd";
type HookToolName = "Write" | "Edit" | null;

type HookResponse = {
	decision?: "block";
	reason?: string;
	hookSpecificOutput?: {
		hookEventName?: string;
		permissionDecision?: "deny";
		permissionDecisionReason?: string;
		updatedInput?: {
			file_path?: string;
			content?: string;
		};
		additionalContext?: string;
	};
};

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

			const text = stdout.trim();
			if (!text) {
				resolve(null);
				return;
			}

			try {
				resolve(JSON.parse(text) as HookResponse);
			} catch (error) {
				reject(new Error(`Failed to parse clj-paren-repair hook output as JSON: ${text}`));
			}
		});

		child.stdin.end(JSON.stringify(payload));
	});
}

export default function (pi: ExtensionAPI) {
	const cwd = process.cwd();
	const originalWrite = createWriteTool(cwd);
	const originalEdit = createEditTool(cwd);

	pi.registerTool({
		name: "write",
		label: "write",
		description: originalWrite.description,
		parameters: originalWrite.parameters,

		async execute(toolCallId, params, signal, onUpdate, ctx) {
			const pre = await runHook(ctx, "PreToolUse", "Write", {
				tool_input: {
					file_path: params.path,
					content: params.content,
				},
			});

			const preBlock = isBlocked(pre);
			if (preBlock.blocked) {
				throw new Error(preBlock.reason ?? "Write blocked by clj-paren-repair hook");
			}

			const updatedPath = pre?.hookSpecificOutput?.updatedInput?.file_path ?? params.path;
			const updatedContent = pre?.hookSpecificOutput?.updatedInput?.content ?? params.content;
			const effectiveParams = { ...params, path: updatedPath, content: updatedContent };

			let result;
			let toolResponse: Record<string, unknown> | null = null;
			try {
				result = await originalWrite.execute(toolCallId, effectiveParams, signal, onUpdate);
				toolResponse = { success: true };
			} catch (error) {
				toolResponse = null;
				throw error;
			} finally {
				const post = await runHook(ctx, "PostToolUse", "Write", {
					tool_input: {
						file_path: updatedPath,
						content: updatedContent,
					},
					tool_response: toolResponse,
				});

				const postBlock = isBlocked(post);
				if (postBlock.blocked) {
					throw new Error(postBlock.reason ?? "Post-write blocked by clj-paren-repair hook");
				}
			}

			return result;
		},
	});

	pi.registerTool({
		name: "edit",
		label: "edit",
		description: originalEdit.description,
		parameters: originalEdit.parameters,

		async execute(toolCallId, params, signal, onUpdate, ctx) {
			const pre = await runHook(ctx, "PreToolUse", "Edit", {
				tool_input: {
					file_path: params.path,
					old_string: params.oldText,
					new_string: params.newText,
					replace_all: params.replaceAll,
				},
			});

			const preBlock = isBlocked(pre);
			if (preBlock.blocked) {
				throw new Error(preBlock.reason ?? "Edit blocked by clj-paren-repair hook");
			}

			let result;
			let toolResponse: Record<string, unknown> | null = null;
			try {
				result = await originalEdit.execute(toolCallId, params, signal, onUpdate);
				toolResponse = { success: true };
			} catch (error) {
				toolResponse = null;
				throw error;
			} finally {
				const post = await runHook(ctx, "PostToolUse", "Edit", {
					tool_input: {
						file_path: params.path,
						old_string: params.oldText,
						new_string: params.newText,
						replace_all: params.replaceAll,
					},
					tool_response: toolResponse,
				});

				const postBlock = isBlocked(post);
				if (postBlock.blocked) {
					throw new Error(postBlock.reason ?? "Post-edit blocked by clj-paren-repair hook");
				}
			}

			return result;
		},
	});

	pi.on("session_shutdown", async (_event, ctx) => {
		await runHook(ctx, "SessionEnd", null, {});
	});
}
