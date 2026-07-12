import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { getSkillsByName, readProcessedSkillBlock, SKILL_PREFIX } from "./skill-loader.js";

const SKILL_INVOCATION_PATTERN = /(^|[^\w/-])\/skill:([a-z0-9](?:[a-z0-9-]{0,62}[a-z0-9])?)(?=$|[^a-z0-9-])/g;
const WRAPPED_PREFIX = "<skill ";
const WRAPPED_SKILL_PATTERN = /<skill\b[\s\S]*?<\/skill>/g;

export default function inlineSkillInvocation(pi: ExtensionAPI): void {
	pi.on("input", async (event, ctx) => {
		if (event.source === "extension" || !event.text.includes(SKILL_PREFIX)) {
			return { action: "continue" };
		}

		if (event.text.startsWith(WRAPPED_PREFIX)) {
			return { action: "continue" };
		}

		// Leave start-of-prompt skills to Pi core or @juicesharp/rpiv-args.
		if (event.text.startsWith(SKILL_PREFIX)) {
			return { action: "continue" };
		}

		const invocations = findInvocationsOutsideSkillBlocks(event.text);
		if (invocations.length === 0) return { action: "continue" };

		const skillsByName = getSkillsByName(pi);
		const unknown = invocations.filter((invocation) => !skillsByName.has(invocation.name));
		if (unknown.length > 0) {
			ctx.ui.notify(
				`Unknown skill invocation(s): ${Array.from(new Set(unknown.map((invocation) => invocation.name))).join(", ")}`,
				"warning",
			);
		}

		const blocks = new Map<string, string>();
		for (const invocation of invocations) {
			const skill = skillsByName.get(invocation.name);
			if (!skill || blocks.has(invocation.name)) continue;

			try {
				blocks.set(invocation.name, await readProcessedSkillBlock(skill, pi, ctx.sessionManager.getSessionId()));
			} catch (error) {
				ctx.ui.notify(
					`Failed to read skill ${invocation.name}: ${error instanceof Error ? error.message : String(error)}`,
					"warning",
				);
			}
		}

		if (blocks.size === 0) return { action: "continue" };

		const expanded = replaceInvocationsOutsideSkillBlocks(event.text, blocks);
		return { action: "transform", text: normalizeBlankLines(expanded), images: event.images };
	});
}

function findInvocationsOutsideSkillBlocks(text: string): Array<{ name: string }> {
	const ranges = skillBlockRanges(text);
	const result: Array<{ name: string }> = [];
	const pattern = new RegExp(SKILL_INVOCATION_PATTERN.source, "g");
	for (const match of text.matchAll(pattern)) {
		const index = match.index ?? 0;
		if (ranges.some((range) => index >= range.start && index < range.end)) continue;
		result.push({ name: match[2] });
	}
	return result;
}

function replaceInvocationsOutsideSkillBlocks(text: string, blocks: Map<string, string>): string {
	const ranges = skillBlockRanges(text);
	const pattern = new RegExp(SKILL_INVOCATION_PATTERN.source, "g");
	return text.replace(pattern, (fullMatch: string, prefix: string, name: string, offset: number) => {
		if (ranges.some((range) => offset >= range.start && offset < range.end)) return fullMatch;
		const block = blocks.get(name);
		return block ? `${prefix}\n\n${block}\n\n` : fullMatch;
	});
}

function skillBlockRanges(text: string): Array<{ start: number; end: number }> {
	const result: Array<{ start: number; end: number }> = [];
	for (const match of text.matchAll(WRAPPED_SKILL_PATTERN)) {
		const start = match.index ?? 0;
		result.push({ start, end: start + match[0].length });
	}
	return result;
}

function normalizeBlankLines(text: string): string {
	return text.replace(/\n{4,}/g, "\n\n\n").trim();
}
