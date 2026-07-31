#!/usr/bin/env bash
# PreToolUse(Bash): block direct `gh pr create`; route it through the
# pr-description skill. The skill's own create step prefixes PR_SKILL=1, which
# is the allowed escape hatch.
cmd=$(jq -r '.tool_input.command // empty' 2>/dev/null)
if printf '%s' "$cmd" | grep -Eq 'gh[[:space:]]+pr[[:space:]]+create' \
   && ! printf '%s' "$cmd" | grep -q 'PR_SKILL=1'; then
  echo "Direct 'gh pr create' is blocked. Use the pr-description skill: it drafts the title+body in Dominic's voice, opens it in his nvim for review, then creates the PR itself." >&2
  exit 2
fi
exit 0
