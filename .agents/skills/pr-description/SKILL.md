---
name: pr-description
description: Use when drafting, writing, or opening a pull request (gh pr create), or asked for a PR title/body/description.
---

# PR description

## Voice

Use the `prose-voice` skill.

- No ticket-number prefix on the title, no trailing period.
- No `## Test plan` heading and no `- [ ]` checklists.
- No mention of earlier revisions, intermediate versions, or abandoned
  approaches ("earlier revisions split out…", "previously this used…", "this
  no longer does X"). Describe the change as it lands against the base branch —
  the linear history the diff produces — not the path taken to get there. The
  reader wants the final shape, not the detour.
- **Length scales with change weight.** Trivial → title-only (empty body is
  fine) or 1–2 sentences. Substantial → `## Summary` / `## Why` prose,
  optionally a results table. Headings are fine at size.
- **Build-on / by-analogy** when it fits — link the prior work ("Continuing
  from…", "Building on…") or point at an existing pattern ("same shape as X").
- **Body describes the why**: How the PR works is answered by the code, not the PR Description.

## Hard rule: review before create

Direct `gh pr create` is blocked by a hook — this flow is the only path.

1. Draft to a temp file (`/tmp/pr-<slug>.md`) using the template below.
2. Open for review via the `remote-edit` skill (blocking open).
3. On return, re-read the file. Parse front matter → flags, first content line →
   title, remainder → body.
4. Create it: `PR_SKILL=1 gh pr create --title <title> --body-file <body> [flags]`.
   The `PR_SKILL=1` prefix is what the hook allows through — omit it elsewhere.

## Default template

```
---
# gh pr create fields — leave blank to omit. Title = first line below, body = rest.
base:                 # -B  branch to merge into (default: repo default)
head:                 # -H  branch with the commits (default: current)
reviewer:             # -r  handle(s), comma-separated
assignee:             # -a  login(s), @me for self
label:                # -l  name(s), comma-separated
milestone:            # -m  name
project:              # -p  title
draft: false          # -d  true to open as draft
no-maintainer-edit: false   # --no-maintainer-edit
---
Title goes on this line

Body prose goes here.
```

Map each non-empty front-matter key to its flag (comma-separated values →
repeated flags, e.g. `label: a,b` → `-l a -l b`). Booleans emit the bare flag
only when true. Title comes from `--title` (first content line), body from
`--body-file` (the content after the title, written to its own temp file).
