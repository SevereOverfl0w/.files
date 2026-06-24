import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { getSkillsByName } from "./skill-loader.js";

const SKILL_MARKER_PATTERN = /(?:^|[\s([{])(\/[a-z0-9:-]*)$/;

export default function skillAutocomplete(pi: ExtensionAPI): void {
	pi.on("session_start", (_event, ctx) => {
		ctx.ui.addAutocompleteProvider((current) => ({
			triggerCharacters: ["/", ":"],

			async getSuggestions(lines, cursorLine, cursorCol, options) {
				const match = skillMatch(lines, cursorLine, cursorCol);
				if (!match) return current.getSuggestions(lines, cursorLine, cursorCol, options);

				const skills = Array.from(getSkillsByName(pi).values()).sort((a, b) => a.name.localeCompare(b.name));
				return {
					prefix: match.prefix,
					items: skills
						.filter((skill) => skill.name.startsWith(match.typed))
						.map((skill) => ({
							value: `/skill:${skill.name}`,
							label: `/skill:${skill.name}`,
							description: skill.path,
						})),
				};
			},

			applyCompletion(lines, cursorLine, cursorCol, item, prefix) {
				return current.applyCompletion(lines, cursorLine, cursorCol, item, prefix);
			},

			shouldTriggerFileCompletion(lines, cursorLine, cursorCol) {
				return current.shouldTriggerFileCompletion?.(lines, cursorLine, cursorCol) ?? true;
			},
		}));
	});
}

function skillMatch(lines: string[], cursorLine: number, cursorCol: number): { prefix: string; typed: string } | null {
	const line = lines[cursorLine] ?? "";
	const beforeCursor = line.slice(0, cursorCol);
	const match = beforeCursor.match(SKILL_MARKER_PATTERN);
	if (!match) return null;

	const prefix = match[1] ?? "";
	const marker = prefix.slice(1);
	if (marker.includes(":")) {
		const [command, typed = ""] = marker.split(":", 2);
		if (command !== "skill") return null;
		return { prefix, typed };
	}

	if (!"skill".startsWith(marker)) return null;
	return { prefix, typed: "" };
}
