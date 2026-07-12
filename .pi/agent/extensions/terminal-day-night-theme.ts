import { readFile, writeFile } from "node:fs/promises";
import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";

const ESC = "\x1b";
const QUERY_CURRENT_MODE = `${ESC}[?996n`;
const ENABLE_NOTIFICATIONS = `${ESC}[?2031h`;
const DISABLE_NOTIFICATIONS = `${ESC}[?2031l`;
const QUERY_2031_SUPPORT = `${ESC}[?2031$p`;

const DARK_REPORT = `${ESC}[?997;1n`;
const LIGHT_REPORT = `${ESC}[?997;2n`;
const MODE_REPORT_PREFIX = `${ESC}[?2031;`;
const MODE_REPORT_SUFFIX = "$y";
const MAX_TAIL = 16;
const CONFIG_PATH = process.env.PI_TERMINAL_THEME_CONFIG || `${process.env.HOME}/.pi/agent/extensions/terminal-day-night-theme.json`;
const DEFAULT_LIGHT_THEME = process.env.PI_TERMINAL_LIGHT_THEME || "light";
const DEFAULT_DARK_THEME = process.env.PI_TERMINAL_DARK_THEME || "dark";

type Mode = "light" | "dark";
type Config = {
	lightTheme: string;
	darkTheme: string;
};

async function loadConfig(): Promise<Config> {
	try {
		const raw = await readFile(CONFIG_PATH, "utf8");
		const parsed = JSON.parse(raw) as Partial<Config>;
		return {
			lightTheme: parsed.lightTheme || DEFAULT_LIGHT_THEME,
			darkTheme: parsed.darkTheme || DEFAULT_DARK_THEME,
		};
	} catch {
		return {
			lightTheme: DEFAULT_LIGHT_THEME,
			darkTheme: DEFAULT_DARK_THEME,
		};
	}
}

async function saveConfig(config: Config): Promise<void> {
	await writeFile(CONFIG_PATH, `${JSON.stringify(config, null, 2)}\n`, "utf8");
}

export default function (pi: ExtensionAPI) {
	let listenerAttached = false;
	let tail = "";
	let currentMode: Mode | null = null;
	let latestCtx: ExtensionContext | null = null;
	let supportTimeout: ReturnType<typeof setTimeout> | null = null;
	let manualQueryTimeout: ReturnType<typeof setTimeout> | null = null;
	let pendingManualQuery = false;
	let dec2031Supported: boolean | null = null;
	let config: Config = {
		lightTheme: DEFAULT_LIGHT_THEME,
		darkTheme: DEFAULT_DARK_THEME,
	};

	const cleanupSupportTimeout = () => {
		if (supportTimeout) {
			clearTimeout(supportTimeout);
			supportTimeout = null;
		}
	};

	const cleanupManualQueryTimeout = () => {
		if (manualQueryTimeout) {
			clearTimeout(manualQueryTimeout);
			manualQueryTimeout = null;
		}
	};

	const notifyManualQueryResult = (message: string, level: "info" | "warning" | "error" = "info") => {
		if (!pendingManualQuery || !latestCtx?.hasUI) return;
		pendingManualQuery = false;
		cleanupManualQueryTimeout();
		latestCtx.ui.notify(message, level);
	};

	const setThemeForMode = (mode: Mode) => {
		if (!latestCtx?.hasUI) return;
		const themeName = mode === "dark" ? config.darkTheme : config.lightTheme;
		const result = latestCtx.ui.setTheme(themeName);
		if (result.success) {
			const changed = currentMode !== mode;
			currentMode = mode;
			if (pendingManualQuery) {
				notifyManualQueryResult(`Terminal reports ${mode} mode; pi theme set to ${themeName}.`);
			} else if (changed) {
				latestCtx.ui.notify(`Terminal switched to ${mode} mode → pi theme ${themeName}`, "info");
			}
		} else if (pendingManualQuery) {
			notifyManualQueryResult(
				`Terminal reports ${mode} mode, but pi could not switch to theme ${themeName}: ${result.error}`,
				"error",
			);
		}
	};

	const writeSequence = (sequence: string) => {
		if (!process.stdout.writable) return;
		process.stdout.write(sequence);
	};

	const requestCurrentMode = () => writeSequence(QUERY_CURRENT_MODE);
	const enableNotifications = () => writeSequence(ENABLE_NOTIFICATIONS);
	const disableNotifications = () => writeSequence(DISABLE_NOTIFICATIONS);
	const query2031Support = () => writeSequence(QUERY_2031_SUPPORT);

	const handleModeSupportReport = (input: string) => {
		let searchFrom = 0;
		while (true) {
			const start = input.indexOf(MODE_REPORT_PREFIX, searchFrom);
			if (start === -1) return;
			const valueIndex = start + MODE_REPORT_PREFIX.length;
			const state = input.charCodeAt(valueIndex);
			const suffixIndex = valueIndex + 1;
			if (state >= 48 && state <= 52 && input.startsWith(MODE_REPORT_SUFFIX, suffixIndex)) {
				cleanupSupportTimeout();
				dec2031Supported = state !== 48;
				if (dec2031Supported) {
					enableNotifications();
					requestCurrentMode();
				} else if (pendingManualQuery) {
					notifyManualQueryResult("Terminal does not report support for DEC mode 2031.", "warning");
				}
				searchFrom = suffixIndex + MODE_REPORT_SUFFIX.length;
			} else {
				searchFrom = start + 1;
			}
		}
	};

	const handleTerminalInput = (chunk: Buffer | string) => {
		const text = typeof chunk === "string" ? chunk : chunk.toString("utf8");
		if (!text.includes(ESC) && !tail) return;

		const input = tail + text;

		if (input.includes(DARK_REPORT)) setThemeForMode("dark");
		if (input.includes(LIGHT_REPORT)) setThemeForMode("light");
		if (input.includes(MODE_REPORT_PREFIX)) handleModeSupportReport(input);

		tail = input.slice(-MAX_TAIL);
	};

	const attachListener = () => {
		if (listenerAttached) return;
		process.stdin.on("data", handleTerminalInput);
		listenerAttached = true;
	};

	const detachListener = () => {
		if (!listenerAttached) return;
		process.stdin.off("data", handleTerminalInput);
		listenerAttached = false;
		tail = "";
	};

	const startSync = (manual = false) => {
		attachListener();
		if (manual) {
			pendingManualQuery = true;
			cleanupManualQueryTimeout();
			manualQueryTimeout = setTimeout(() => {
				pendingManualQuery = false;
				if (!latestCtx?.hasUI) return;
				const supportText = dec2031Supported === false ? " DEC 2031 appears unsupported." : "";
				latestCtx.ui.notify(`No terminal day/night mode response received.${supportText}`, "warning");
			}, 1500);
		}
		query2031Support();
		requestCurrentMode();
		cleanupSupportTimeout();
		supportTimeout = setTimeout(() => {
			requestCurrentMode();
		}, 300);
	};

	const chooseTheme = async (ctx: ExtensionContext, mode: Mode) => {
		const themes = ctx.ui.getAllThemes().map((theme) => theme.name).sort();
		const current = mode === "dark" ? config.darkTheme : config.lightTheme;
		const selected = await ctx.ui.select(
			`Select ${mode} mode theme (current: ${current})`,
			themes,
		);
		if (!selected) return;
		if (mode === "dark") config.darkTheme = selected;
		else config.lightTheme = selected;
		await saveConfig(config);
		ctx.ui.notify(`Set ${mode} mode theme to ${selected}.`, "info");
	};

	const openSettings = async (ctx: ExtensionContext) => {
		while (true) {
			const choice = await ctx.ui.select("Terminal day/night theme settings", [
				`Dark mode theme: ${config.darkTheme}`,
				`Light mode theme: ${config.lightTheme}`,
				"Test query now",
				"Reset to defaults",
				"Done",
			]);

			if (!choice || choice === "Done") return;
			if (choice.startsWith("Dark mode theme:")) {
				await chooseTheme(ctx, "dark");
				continue;
			}
			if (choice.startsWith("Light mode theme:")) {
				await chooseTheme(ctx, "light");
				continue;
			}
			if (choice === "Test query now") {
				latestCtx = ctx;
				startSync(true);
				continue;
			}
			if (choice === "Reset to defaults") {
				config = {
					lightTheme: DEFAULT_LIGHT_THEME,
					darkTheme: DEFAULT_DARK_THEME,
				};
				await saveConfig(config);
				ctx.ui.notify("Reset terminal day/night theme mappings to defaults.", "info");
			}
		}
	};

	pi.on("session_start", async (_event, ctx) => {
		if (!ctx.hasUI) return;
		latestCtx = ctx;
		config = await loadConfig();
		startSync();
	});

	pi.on("session_shutdown", async () => {
		cleanupSupportTimeout();
		cleanupManualQueryTimeout();
		disableNotifications();
		detachListener();
		latestCtx = null;
	});

	pi.registerCommand("theme-sync-query", {
		description: "Query the terminal for its current light/dark mode and show the detected result",
		handler: async (_args, ctx) => {
			latestCtx = ctx;
			config = await loadConfig();
			startSync(true);
		},
	});

	pi.registerCommand("theme-sync-settings", {
		description: "Configure which pi theme to use for terminal light and dark mode",
		handler: async (_args, ctx) => {
			latestCtx = ctx;
			config = await loadConfig();
			await openSettings(ctx);
		},
	});
}
