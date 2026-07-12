import { readFile } from "node:fs/promises";
import { existsSync } from "node:fs";
import { homedir } from "node:os";
import { dirname, join } from "node:path";
import { loadSkills, loadSkillsFromDir, type ExtensionAPI, type Skill } from "@earendil-works/pi-coding-agent";
import {
	executeShellInBody,
	parseCommandArgs,
	resolveShellTimeoutMs,
	substituteArgs,
	substituteVariables,
} from "@juicesharp/rpiv-args/args.ts";

export const SKILL_PREFIX = "/skill:";

export interface SkillCommandInfo {
	readonly name: string;
	readonly path: string;
	readonly baseDir: string;
}

interface CommandLike {
	readonly name: string;
	readonly source: string;
	readonly sourceInfo: {
		readonly path: string;
		readonly baseDir?: string;
	};
}

interface FrontmatterResult<T> {
	readonly frontmatter: T;
	readonly body: string;
}

export function getSkillsByName(pi: ExtensionAPI): Map<string, SkillCommandInfo> {
	const result = new Map<string, SkillCommandInfo>();
	for (const skill of loadSkillsFromPi()) {
		result.set(skill.name, skillToInfo(skill));
	}
	for (const command of pi.getCommands() as Iterable<CommandLike>) {
		if (command.source !== "skill") continue;
		const skill = sourceInfoToSkill(command);
		if (skill) result.set(skill.name, skill);
	}
	return result;
}

export function findSkill(pi: ExtensionAPI, rawName: string): SkillCommandInfo | undefined {
	const name = normalizeSkillName(rawName);
	return getSkillsByName(pi).get(name);
}

export async function readProcessedSkillBlock(
	skill: SkillCommandInfo,
	pi: ExtensionAPI,
	sessionId: string,
	args: string[] = [],
): Promise<string> {
	const content = await readFile(skill.path, "utf-8");
	const { frontmatter, body } = parseFrontmatter<{ "shell-timeout"?: unknown }>(content);
	const timeoutMs = resolveShellTimeoutMs(frontmatter);
	let processed = body.trim();

	processed = substituteArgs(processed, args);
	processed = substituteVariables(processed, { skillDir: skill.baseDir, sessionId });
	processed = await executeShellInBody(processed, pi, process.cwd(), timeoutMs);

	return `<skill name="${skill.name}" location="${skill.path}">\nReferences are relative to ${skill.baseDir}.\n\n${processed}\n</skill>`;
}

export function parseSkillArgs(args?: string | string[]): string[] {
	if (!args) return [];
	return Array.isArray(args) ? args : parseCommandArgs(args);
}

function sourceInfoToSkill(command: CommandLike): SkillCommandInfo | null {
	if (!command.name.startsWith(SKILL_PREFIX)) return null;
	const name = command.name.slice(SKILL_PREFIX.length);
	if (!name) return null;
	return {
		name,
		path: command.sourceInfo.path,
		baseDir: command.sourceInfo.baseDir ?? dirname(command.sourceInfo.path),
	};
}

function loadSkillsFromPi(): Skill[] {
	const agentDir = process.env.PI_CODING_AGENT_DIR ?? join(homedir(), ".pi", "agent");
	const loaded = loadSkills({
		cwd: process.cwd(),
		agentDir,
		skillPaths: [],
		includeDefaults: true,
	}).skills;
	for (const dir of agentSkillDirs()) {
		if (existsSync(dir)) loaded.push(...loadSkillsFromDir({ dir, source: "agents" }).skills);
	}
	return loaded;
}

function agentSkillDirs(): string[] {
	const dirs = [join(homedir(), ".agents", "skills")];
	let current = process.cwd();
	while (true) {
		const dir = join(current, ".agents", "skills");
		if (dir !== dirs[0]) dirs.push(dir);
		const parent = dirname(current);
		if (parent === current) return dirs;
		current = parent;
	}
}

function skillToInfo(skill: Skill): SkillCommandInfo {
	return {
		name: skill.name,
		path: skill.filePath,
		baseDir: skill.baseDir,
	};
}

function normalizeSkillName(rawName: string): string {
	return rawName.trim().replace(/^\/skill:/, "").replace(/^skill:/, "");
}

function parseFrontmatter<T extends Record<string, unknown>>(content: string): FrontmatterResult<T> {
	const normalized = content.replace(/^\uFEFF/, "");
	const match = normalized.match(/^---\r?\n([\s\S]*?)\r?\n---\r?\n?/);
	if (!match) return { frontmatter: {} as T, body: normalized };
	return { frontmatter: parseYamlSubset(match[1] ?? "") as T, body: normalized.slice(match[0].length) };
}

function parseYamlSubset(yaml: string): Record<string, unknown> {
	const result: Record<string, unknown> = {};
	for (const line of yaml.split(/\r?\n/)) {
		const match = line.match(/^([A-Za-z0-9_-]+):\s*(.*?)\s*$/);
		if (!match) continue;
		result[match[1]] = parseScalar(match[2] ?? "");
	}
	return result;
}

function parseScalar(value: string): unknown {
	const trimmed = value.trim();
	if (/^-?\d+(?:\.\d+)?$/.test(trimmed)) return Number(trimmed);
	if (trimmed === "true") return true;
	if (trimmed === "false") return false;
	return trimmed.replace(/^(['"])(.*)\1$/, "$2");
}
