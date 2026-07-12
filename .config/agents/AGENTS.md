# Code Style
- **Use the most direct form** — if a simpler expression exists, use it. Don't compose two constructs when one does the job.
- **Work with the system, not around it** — use the abstractions the codebase provides rather than bypassing them. If there's a spec, generate through it; don't stamp values on after the fact.
- **Fix at the right level** — if a function returns the wrong shape, fix the function. Don't patch every caller.
- **Don't extract prematurely** — if something is used once, inline it. Extraction earns its keep through reuse.
- **Separate the exception from the pattern** — if something doesn't fit, keep it out. Don't add opt-outs, special-case arities, or sentinel values to make a uniform abstraction accommodate its one exception.
- only use docstrings document the contract (inputs, outputs, invariants to rely on) allowing space for impl change in future.
- only use comments for the why that isn't visible from the code itself, e.g. non-obvious constraints, the historical reason something was done this way, a subtle invariant a future reader would miss.

# Approach
- Think before acting. Read existing files before writing code.
- Be concise in output but thorough in reasoning.
- Prefer editing over rewriting whole files.
- Do not re-read files you have already read unless the file may have changed.
- Test your code before declaring done.
- No sycophantic openers or closing fluff.
- Keep solutions simple and direct.
- User instructions always override this file.


I structure my worktrees as [/path/to/repo/]worktrees/[branch/name].
If you're in a worktree only read files within that worktree unless explicitly told otherwise.
