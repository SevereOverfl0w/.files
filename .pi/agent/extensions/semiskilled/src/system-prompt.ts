import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const READ_SKILL_INSTRUCTION = "Use the read tool to load a skill's file when the task matches its description.";
const LOAD_SKILL_INSTRUCTION = "Use the load_skill tool to load a skill when the task matches its description.";

export default function systemPrompt(pi: ExtensionAPI): void {
	pi.on("before_agent_start", (event) => ({
		systemPrompt: event.systemPrompt.includes(READ_SKILL_INSTRUCTION)
			? event.systemPrompt.replace(READ_SKILL_INSTRUCTION, LOAD_SKILL_INSTRUCTION)
			: `${event.systemPrompt}\n\n${LOAD_SKILL_INSTRUCTION}`,
	}));
}
