---
name: remote-edit
description: Hand a file to the user's running editor and block until they finish editing it. Use whenever a draft (PR body, ticket, commit message, any generated file) needs the user's review before you act on it, or when a task says "open this in my editor/vim/nvim".
allowed-tools: Bash(bash ${CLAUDE_SKILL_DIR}/remote-edit.sh *)
---

Live servers (address + cwd):

```
!`bash /Users/dominicmonroe/.claude/skills/remote-edit/remote-edit.sh list`
```

## Open a file for review

```
bash ${CLAUDE_SKILL_DIR}/remote-edit.sh <file> [server]
```

Opens `<file>` in a new tab and blocks. Omit `server` when exactly one is live.

## Which server

- One live → use it, don't ask.
- Several → pick the one whose cwd contains the file, or is the repo/worktree the
  task is about. Worktrees are separate servers: `…/repo/worktrees/foo` is not
  `…/repo` — match the exact path the work is in.
- Still ambiguous (same cwd, or file outside every cwd) → ask the user.
- None → tell the user; do not start an nvim.

The list above is a snapshot. If the script exits non-zero mid-session the server
died — re-run `remote-edit.sh list` for a fresh one.

## Waiting

Done = the call **returns**, which happens when the user *closes* the tab
(`:wq`), not when they save — a save leaves the wait live and the user still
editing. It blocks past the foreground timeout into the background; that is
normal, keep waiting for completion. A file-modified notification, or a
killed/stopped/interrupted task status, is **not** the finish. Only re-read the
file once the call genuinely returns.
