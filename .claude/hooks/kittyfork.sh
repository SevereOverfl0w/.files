#!/bin/bash
# /kittyfork — fork the current Claude Code session into a new kitty window in
# the same cwd. Wired as a UserPromptSubmit hook so the model is never invoked.
#
# UserPromptSubmit's `matcher` field does not filter by prompt content, so the
# script must inspect the prompt itself and pass through unchanged otherwise.

set -e

INPUT=$(cat)
PROMPT=$(jq -r '.prompt // empty' <<< "$INPUT")

if [ "$PROMPT" != "#kittyfork" ]; then
  exit 0
fi

SESSION_ID=$(jq -r '.session_id // empty' <<< "$INPUT")
kitten @ launch --cwd=current zsh -l -i -c "claude --fork-session --resume $SESSION_ID" >/dev/null 2>&1 || true
printf '%s\n' '{"decision":"block","reason":"forked into new kitty window"}'
