---
name: linear-ticket
description: Use when drafting, writing, or filing a Linear ticket/issue, or asked for a Linear title/body/description.
---

# Linear ticket

**Voice:** see the `prose-voice` skill.

## Hard rule: review before create

1. Draft to a temp file (`/tmp/lin-<slug>.md`) using the template below.
2. Open for review via the `remote-edit` skill (blocking open).
3. On return, re-read the file. Parse front matter → fields, first content line
   → title, remainder → description.
4. Create it via `mcp__linear__save_issue` (no `id`), mapping the front matter
   below onto its parameters.

## Default template

```
---
# mcp__linear__save_issue fields — leave blank to omit. Title = first line below, body = rest.
team:                 # required — name or ID
project:              # name, ID, or slug
assignee:             # user ID, name, email, or "me"
labels:               # name(s), comma-separated
priority:             # 0 None, 1 Urgent, 2 High, 3 Medium, 4 Low
state:                # workflow state type/name/ID
estimate:             # number
cycle:                # cycle name, number, or ID
milestone:            # name or ID
parentId:             # parent issue ID/identifier (e.g. LIN-123)
dueDate:              # ISO date
---
Title goes on this line

Body prose (Markdown) goes here.
```

Map each non-empty front-matter key to its `save_issue` parameter (`labels` is a
list — split the comma-separated value; `priority`/`estimate` are numbers).
`team` is required on create. Title → `title`, content after it → `description`.
