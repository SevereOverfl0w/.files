---
name: prose-voice
description: Writing voice for authored prose — PR bodies, Linear tickets, review comments, commit messages.
user-invocable: false
---

Declarative, problem-first, terse.

## Body

- **Declarative sentences, present tense, third-person on the code.** "This
  caused…", "These warnings are not helpful…", "Scheduler now supports…".
  First-person is rare — do NOT default to "I noticed / so I fixed it".
- **Problem/context first.** Lead with the existing behaviour, bug, or
  motivation; the fix is implicit or trailing. The title describes the problem,
  the body the why.
- **Backticks** on identifiers, namespaces, specs, paths, test targets.
- **Cite hard numbers** when one exists — "10x speedup", "250ms-450ms in prod",
  "failed 100 times", CI p95/timeout.
- **Links inlined** in the prose where the rationale sits — NOT collected at the
  bottom. A bare link as the whole body when that's the rationale of record.

## Titles

Imperative mood (bare verb stem, no subject), capitalized first letter, <~100 chars, no prefix, no trailing period.
Lead verbs: Like a git commit. E.g. "Add indexes for list-widgets", not "Added…" / "Adds…" / "Adding…".

## Real examples

> **Fix flaky widget Baz generator**
> `s/and string?` failed 100 times to make a compliant string. Custom generator
> makes it always happen.

> **Parallelize Widget Baz lookups**
> Seeing 250ms-450ms times in prod. If 100% of failing widgets are Baz, this adds up.

> **Suppress BD algorithm warnings**
> Fix https://sentry.io/issues/1234/ - these warnings are not helpful and just spam.
