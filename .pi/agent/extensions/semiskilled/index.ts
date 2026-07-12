import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import skillAutocomplete from "./src/autocomplete.js";
import inlineSkillInvocation from "./src/inline-skill-invocation.js";
import loadSkillTool from "./src/load-skill-tool.js";
import systemPrompt from "./src/system-prompt.js";

export default function semiskilled(pi: ExtensionAPI): void {
	skillAutocomplete(pi);
	inlineSkillInvocation(pi);
	loadSkillTool(pi);
	systemPrompt(pi);
}
