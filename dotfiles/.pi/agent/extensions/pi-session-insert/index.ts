import { dirname } from "node:path";
import { SessionManager, SessionSelectorComponent } from "@earendil-works/pi-coding-agent";

function sessionReference(path: string): string {
	return `/skill:session-query\n\n**Parent session:** \`${path}\``;
}

function insertText(ctx: any, text: string): void {
	if (ctx.ui.pasteToEditor) {
		ctx.ui.pasteToEditor(text);
		return;
	}

	ctx.ui.setEditorText?.(`${ctx.ui.getEditorText?.() ?? ""}${text}`);
}

function currentSessionDir(ctx: any): string | undefined {
	return ctx.sessionManager?.getSessionDir?.();
}

function allSessionsRoot(ctx: any): string | undefined {
	const dir = currentSessionDir(ctx);
	return dir ? dirname(dir) : undefined;
}

export default function (pi: any) {
	async function pickAndInsert(_args: string, ctx: any): Promise<void> {
		if (ctx.mode !== "tui") {
			ctx.ui.notify("pi-session-insert requires interactive mode", "error");
			return;
		}

		const selected = await ctx.ui.custom<string | null>((tui: any, _theme: any, keybindings: any, done: (value: string | null) => void) => {
			const currentLoader = (onProgress?: any) => SessionManager.list(ctx.cwd, currentSessionDir(ctx), onProgress);
			const allLoader = (onProgress?: any) => {
				const root = allSessionsRoot(ctx);
				return root ? SessionManager.listAll(root, onProgress) : SessionManager.listAll(onProgress);
			};

			return new SessionSelectorComponent(
				currentLoader,
				allLoader,
				(path: string) => done(path),
				() => done(null),
				() => done(null),
				() => tui.requestRender(),
				{ keybindings, showRenameHint: false },
				ctx.sessionManager.getSessionFile?.(),
			);
		});

		if (!selected) return;
		insertText(ctx, sessionReference(selected));
		ctx.ui.notify("Inserted parent session", "info");
	}


	pi.registerShortcut("alt+shift+s", {
		description: "Search sessions and insert a session-query parent reference",
		handler: (ctx: any) => pickAndInsert("", ctx),
	});
}
