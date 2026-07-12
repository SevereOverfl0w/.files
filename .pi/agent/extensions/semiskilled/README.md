# semiskilled

Pi extension: inline `/skill:name` expansion anywhere in a prompt, with `@juicesharp/rpiv-args` body processing before wrapping.

What it does:

- expands known inline `/skill:name` markers anywhere in prompt
- autocompletes mid-prompt `/skill:` markers
- supports multiple inline skills
- registers `load_skill` so the agent can load a skill by name when another skill references it
- rewrites Pi's skill prompt instruction to use `load_skill` for matching skills
- skips text already inside `<skill ...>...</skill>` blocks
- leaves start-of-prompt `/skill:name args` untouched so Pi core or `@juicesharp/rpiv-args` can handle it
- strips skill frontmatter
- applies rpiv-args substitutions before wrapping:
  - `$1`, `$ARGUMENTS`, `$@`, `${@:N}` with empty argv for now
  - `${SKILL_DIR}` and `${SESSION_ID}`
  - `!\`cmd\`` inline shell substitution
  - ```` ```!
    command
    ``` ```` block shell substitution

Inline arguments are not parsed yet. Text after `/skill:name` remains normal prompt text.

## Tool

`load_skill` loads a Pi skill by name and returns a processed Pi-compatible `<skill>` block.

Parameters:

- `name`: skill name, with or without `/skill:`
- `arguments`: optional shell-style string for `$1`, `$ARGUMENTS`, `$@`, `${@:N}` substitution
