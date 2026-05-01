---
name: vim-quickfix
description: Output lists of locations as vim quickfix lists.
allowed-tools: Bash(mkdir -p .qf), Write(.qf/*), Edit(.qf/*)
---

!`mkdir -p .qf`

# Vim Quickfix Output

## Format 1: Working Tree Files

For entries that reference files in the working tree, write a plain quickfix file.

**File:** `.qf/<task-name>.txt`
**Format:** `file:line:col:message` (one per line, col can be `0` if unknown)

```
src/foo/bar.clj:42:0:TODO: fix this
src/foo/baz.clj:10:5:suspicious pattern
```

**Tell the user:** `:cfile .qf/<task-name>.txt`

## Format 2: Git Commit Files (Fugitive)

For entries that reference files at specific commits (e.g. reviewing TODOs across
a branch's history), write a `.vim` script that calls `setqflist()` with full
fugitive URIs.

**File:** `.qf/<task-name>.vim`

### Getting the git dir

Use `git rev-parse --git-dir` — this returns the correct path in both normal repos
and worktrees.

### Getting full commit SHAs

Fugitive requires full 40-character SHAs

```bash
git rev-parse <short-or-ref>
```

### Fugitive URI format

```
fugitive://<git-dir>//<full-40-char-sha>/<path-from-repo-root>
```

Example:
```
fugitive:///Users/bob/code/repo/.git/worktrees/my-branch//abc123...def/src/foo.clj
```

### Script format

The display formatter lives at `./fugitive-qf.vim` and
defines `g:SkillQfFugitiveText` which strips fugitive URIs to `7b4a70a:path` in the
quickfix window. Source it first, then just emit the `setqflist` call:

```vim
source /absolute/path/to/skills/vim-quickfix/fugitive-qf.vim
let s:g = 'fugitive://<git-dir>//'
call setqflist([], ' ', {
  \ 'title': '<descriptive title for the list>',
  \ 'quickfixtextfunc': 'g:SkillQfFugitiveText',
  \ 'items': [
  \   {'filename': s:g . '<full-sha-1>/src/foo.clj', 'lnum': 42, 'text': 'TODO: fix this'},
  \   {'filename': s:g . '<full-sha-2>/src/bar.clj', 'lnum': 10, 'text': 'TODO: different commit'},
  \ ]})
copen
```

Use a `let` variable for the git dir prefix to avoid repeating it on every line.
The `' '` (space) action creates a new list rather than replacing the current one,
so previous quickfix lists are preserved in the stack (`:colder` to go back).

**Tell the user:** `:source .qf/<task-name>.vim`

## Choosing Between Formats

- Entries reference the current working tree → Format 1 (`:cfile`)
- Entries reference specific commits (branch review, blame, history search) → Format 2 (`:source`)
- Mixed → use Format 2 for everything; working tree files can use `HEAD` as the commit
