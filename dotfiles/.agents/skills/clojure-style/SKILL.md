---
name: clojure-style
description: Clojure style guidelines. Activate before writing or editing Clojure code
---

Build primitives that combine orthogonally. Don't build a function that handles multiple modes via flags — build pieces that the caller composes.
If a simpler expression exists, use it. Extract helpers when there's 3+ repeats.
Use the abstractions and hooks the library/framework provides rather than wrapping or patching after the fact. If a library has a custom dispatch mechanism, use it.

Bad: a function with a `mode` parameter that switches between strategies.
Good: two functions the caller can combine as needed.

with-redefs is never to be used

Write docstrings matching these archetypes. Match their voice, verbosity, and formatting exactly; bare identifiers, no backticks. Key descriptions use " - " (space-dash-space). Optional keys: append ", default = X".
Predicate → clojure.core/nil?
Pure transform → clojure.core/get-in
Multi-arity with branching → clojure.core/reduce
Lazy or transducer → clojure.core/filter
State mutation + caller-fn rule → clojure.core/swap!
Options map → clojure.tools.deps/create-basis (or calc-basis for single-arg options)
Structured return-map → clojure.tools.deps/make-classpath-map
Otherwise generally copy clojure.core, and other core team libs.

Write fn arglist on newline after fn name.
Args: clojure.core. No :as.
