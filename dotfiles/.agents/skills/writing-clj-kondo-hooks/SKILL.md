---
name: writing-clj-kondo-hooks
description: "Write clj-kondo hooks for custom macros using the hooks API and rewrite-clj nodes. Use when creating, editing, or debugging clj-kondo hooks, writing analyze-call or macroexpand hooks, or registering custom lint warnings."
---

# Writing clj-kondo Hooks

Guide for writing clj-kondo hooks that teach clj-kondo about custom macros.

## Overview

Hooks let you extend clj-kondo's linting by transforming macro calls into forms clj-kondo understands, or by registering custom lint findings. Hooks are interpreted via SCI (Small Clojure Interpreter).

## Two Hook Types

### 1. `analyze-call` — Transform or inspect macro calls

- Receives a rewrite-clj node, returns a transformed node or registers findings.
- Config: `{:hooks {:analyze-call {my-lib/my-macro hooks.my-lib/my-macro}}}`

### 2. `macroexpand` — Expand via a macro in config

- Easier to write but loses location precision.
- Config: `{:hooks {:macroexpand {my-lib/my-macro my-lib/my-macro}}}`

## File Placement

- Hook files go in `.clj-kondo/hooks/` (or `.clj-kondo/<ns_path>.clj` for macroexpand).
- Namespace must match directory structure: `hooks.foo` → `.clj-kondo/hooks/foo.clj`
- Config goes in `.clj-kondo/config.edn`.

## Core API (`clj-kondo.hooks-api`)

### Node Constructors (each has a `?` predicate counterpart)

| Function | Purpose |
|---|---|
| `list-node` | Create list node from seq of nodes |
| `vector-node` | Create vector node from seq of nodes |
| `map-node` | Create map node from seq of nodes |
| `keyword-node` | Create keyword node: `(keyword-node :foo)` or `(keyword-node :foo true)` for `::foo` |
| `string-node` | Create string node |
| `token-node` | Create token node (symbols, nil, numbers) |

### Analysis & Utility

| Function | Purpose |
|---|---|
| `sexpr` | Convert node → Clojure s-expression |
| `tag` | Get node's tag keyword |
| `reg-finding!` | Register a custom lint finding (map with `:message`, `:type`, `:row`, `:col`, `:end-row`, `:end-col`) |
| `reg-keyword!` | Mark keyword as a definition for navigation |
| `ns-analysis` | Get cached analysis for a namespace |
| `resolve` | Resolve a symbol to its namespace and name |
| `callstack` | List of parent calls |

### Available Namespaces

`clojure.core`, `clojure.set`, `clojure.string` are available in hook code. Use `println`/`prn` for debugging.

## Workflow

1. **Read the project's `.clj-kondo/config.edn`** to understand existing hooks and config.
2. **Identify the macro** to hook — read its source to understand its syntax.
3. **Choose hook type**: Use `analyze-call` for precise control, `macroexpand` for simple expansions.
4. **Write the hook**, following the patterns below.
5. **Register in config.edn**.
6. **Test** by running `clj-kondo --lint <file>` on code that uses the macro.

## Pattern: analyze-call Transformation

Transform a macro call into equivalent code clj-kondo understands. The transformation does NOT need to match the actual macroexpansion — it just needs to be syntactically valid and express the same bindings/usages.

```clojure
(ns hooks.my-lib
  (:require [clj-kondo.hooks-api :as api]))

(defn my-macro [{:keys [node]}]
  (let [[_ binding-vec & body] (:children node)
        ;; destructure binding-vec, transform as needed
        new-node (api/list-node
                   (list*
                     (api/token-node 'let)
                     binding-vec
                     body))]
    {:node new-node}))
```

**Key points:**
- Hook fn receives `{:keys [node]}` — the full call as a rewrite-clj list node.
- `(:children node)` gives child nodes; first child is the macro symbol itself.
- Return `{:node new-node}` with the transformed node.
- Throw `ex-info` for invalid usage (becomes a clj-kondo warning).

## Pattern: Custom Lint Warning

```clojure
(ns hooks.my-linter
  (:require [clj-kondo.hooks-api :as api]))

(defn my-check [{:keys [node]}]
  (let [;; analyze the node
        problem? true]
    (when problem?
      (api/reg-finding!
        (assoc (meta node)
               :message "Description of the problem"
               :type :my-ns/my-lint-type))))
  ;; return nil if no transformation needed
  nil)
```

Config must set a level for the lint type:
```clojure
{:linters {:my-ns/my-lint-type {:level :warning}}
 :hooks {:analyze-call {my-ns/my-fn hooks.my-linter/my-check}}}
```

## Pattern: macroexpand Hook

Place macro in `.clj-kondo/<ns_path>.clj` matching original namespace:

```clojure
;; .clj-kondo/my_lib.clj
(ns my-lib)

(defmacro my-macro [& args]
  ;; expand into valid Clojure
  `(do ~@args))
```

Config:
```clojure
{:hooks {:macroexpand {my-lib/my-macro my-lib/my-macro}}}
```

## Rewrite-clj Node Structure

`(my-macro 1 2 3)` →
- list-node with `:children`: `[token:my-macro, token:1, token:2, token:3]`

`[a 1 {:k true}]` →
- vector-node with `:children`: `[token:a, token:1, map-node[keyword::k, token:true]]`

Metadata (`^:foo []`) is stored in `:meta` key on the value node, not as a separate node.

## Ignoring Warnings in Generated Nodes

```clojure
(vary-meta new-node assoc :clj-kondo/ignore [:some-linter])
```

## Debugging

- Use `println`/`prn` in hook code.
- `(prn (api/sexpr node))` to inspect nodes.
- Pass `--debug` to clj-kondo for extra checks (not in production).

## Reference

For the full upstream documentation with all details and edge cases, read `reference/hooks-full.md` in this skill directory.
