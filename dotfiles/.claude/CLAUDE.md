@~/.files/_agent/AGENTS.md

# Commit Editing
When working on a multi-commit branch, before making a new commit, check
whether the change belongs in an existing commit. If it extends an earlier
commit's idea — a fix, an addition, a test for that commit's code — use
`/rebase-edit` to place it there. This keeps commits ordered by epistemic
dependency: each introduces one idea, reviewable with only prior commits
as context.
