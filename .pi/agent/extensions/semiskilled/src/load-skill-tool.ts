import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { Type } from "typebox";
import { findSkill, getSkillsByName, parseSkillArgs, readProcessedSkillBlock } from "./skill-loader.js";

interface LoadSkillParams {
	readonly name: string;
	readonly arguments?: string;
}

interface ToolContext {
	readonly sessionManager: {
		getSessionId(): string;
	};
}

export default function loadSkillTool(pi: ExtensionAPI): void {
	pi.registerTool({
		name: "load_skill",
		label: "Load Skill",
		description: "Load a Pi skill by name and return its processed <skill> block.",
		promptSnippet: "Load referenced Pi skills on demand.",
		promptGuidelines: [
			"Use load_skill when a skill body references another skill by name or asks you to use another skill.",
			"Use load_skill when the user mentions an available skill that has not been expanded into the prompt.",
		],
		parameters: Type.Object({
			name: Type.String({ description: "Skill name, with or without /skill: prefix" }),
			arguments: Type.Optional(Type.String({ description: "Shell-style argument string for $1/$ARGUMENTS substitution" })),
		}),
		async execute(_toolCallId: string, params: LoadSkillParams, _signal: unknown, _onUpdate: unknown, ctx: ToolContext) {
			const skill = findSkill(pi, params.name);
			if (!skill) {
				const known = Array.from(getSkillsByName(pi).keys()).sort().join(", ");
				return {
					content: [{ type: "text", text: `Unknown skill: ${params.name}\n\nKnown skills: ${known}` }],
					details: { found: false, requested: params.name },
				};
			}

			const args = parseSkillArgs(params.arguments);
			const block = await readProcessedSkillBlock(skill, pi, ctx.sessionManager.getSessionId(), args);
			return {
				content: [{ type: "text", text: block }],
				details: { found: true, name: skill.name, path: skill.path, args },
			};
		},
	});
}
