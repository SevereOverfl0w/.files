# clj-kondo Hooks — Full Reference

Source: https://github.com/clj-kondo/clj-kondo/blob/master/doc/hooks.md

## API

Hooks are interpreted using the [Small Clojure Interpreter](https://github.com/borkdude/sci).

Hooks receive Clojure code as rewrite-clj nodes, not only for performance
reasons, but also because rewrite-clj nodes carry the line and row numbers for
every Clojure element. Note that clj-kondo's version of rewrite-clj is catered
to its use case, includes some bug fixes, but most notably: strips away all
whitespace.

A hook can leverage the `clj-kondo.hooks-api` namespace for transformation and
analysis of rewrite-clj nodes.

### Node Constructors

- `list-node`: produce a new list node from a seqable of nodes.
- `vector-node`: produce a new vector node from a seqable of nodes.
- `map-node`: produce a new map node from a seqable of nodes.
- `keyword-node`: produce a new keyword. Use `(api/keyword-node :foo)` for a
  normal keyword and `(api/keyword-node :foo true)` to produce a node for `::foo`.
- `string-node`: produce a new node for a single string or multiple strings (passed as seq).
- `token-node`: produce a new token node. Used for all remaining tokens (mainly symbols or nil).
- `tag`: return the tag keyword for a node.

Each producing function has a predicate counterpart (`list-node?`, etc.).

### Other API Functions

- `sexpr`: turns a node into a Clojure s-expression. Useful for analyzing concrete values.
- `reg-keyword!`: indicates that a keyword's analysis should be marked as a
  definition. Expects the keyword node and either `true` or the fully-qualified
  function that registered it. Returns a new keyword node that must be in the
  transformed body. Used to implement keyword navigation for clojure-lsp.
- `tag`: returns node's tag, can be used as a dispatch function for multimethods.
- `reg-finding!`: registers a finding. Expects a map with:
  - `:message`: the lint message
  - `:row`, `:col`, `:end-row` and `:end-col`: location (from node metadata)
  - `:type`: lint warning type. A level must be set in config under `:linters`.
- `ns-analysis`: Return cached analysis for a namespace. Returns map keyed by
  language keyword with values being maps of var definitions keyed by symbol.
  Arglists: `[ns-sym]`, `[ns-sym {:keys [lang]}]`.
- `resolve`: Takes a map of `:name` (symbol) and optional `:call` (boolean).
  Returns map with `:ns` and `:name`.
- `callstack`: a list of functions/macros parent calls.

Available namespaces: `clojure.core`, `clojure.set`, `clojure.string`.
Use `println`/`prn` for debugging, `time` for performance.

### Configuration

```clojure
{:hooks {:analyze-call {foo/weird-macro hooks.foo/weird-macro}}}
```

## analyze-call

The `analyze-call` hook lints macros unrecognized by clj-kondo that cannot be
supported by `:lint-as`.

It receives macro/function call code as a rewrite-clj node, and can:
- Transform the code to teach clj-kondo about its effect.
- Inspect call arguments and emit findings.

### Rewrite-clj Node Structure

`(my-macro 1 2 3)` becomes:
- list node with `:children`: token `my-macro`, token `1`, token `2`, token `3`

`(my-lib/with-bound [a 1 {:with-bound/setting true}] (inc a))` becomes:
- list node with `:children`:
  - token `my-lib/with-bound`
  - vector node with `:children`: token `a`, token `1`, map node (keyword `:with-bound/setting`, token `true`)
  - list node: token `inc`, token `a`

Metadata: `^:foo ^:bar []` — vector node with `:meta` containing seq of keyword nodes `:foo`, `:bar`.

### Transformation Example

Given macro:
```clojure
(ns mylib)
(defmacro with-bound [binding-vector & body] ,,,)
```

Usage: `(my-lib/with-bound [a 1 {:with-bound/setting true}] (inc a))`

Hook transforms to: `(let [a 1] {:with-bound/setting true} (inc a))`

```clojure
(ns hooks.with-bound
  (:require [clj-kondo.hooks-api :as api]))

(defn with-bound [{:keys [node]}]
  (let [[binding-vec & body] (rest (:children node))
        [sym val opts] (:children binding-vec)]
    (when-not (and sym val)
      (throw (ex-info "No sym and val provided" {})))
    (let [new-node (api/list-node
                    (list*
                     (api/token-node 'let)
                     (api/vector-node [sym val])
                     opts
                     body))]
      {:node new-node})))
```

File: `.clj-kondo/hooks/with_bound.clj`
Config: `{:hooks {:analyze-call {my-lib/with-bound hooks.with-bound/with-bound}}}`

The symbol `hooks.with-bound/with-bound` corresponds to `.clj-kondo/hooks/with_bound.clj`.

### Custom Lint Warnings

Example for re-frame dispatch checking qualified keywords:

```clojure
(ns hooks.re-frame
  (:require [clj-kondo.hooks-api :as api]))

(defn dispatch [{:keys [node]}]
  (let [sexpr (api/sexpr node)
        event (second sexpr)
        kw (first event)]
    (when (and (vector? event)
               (keyword? kw)
               (not (qualified-keyword? kw)))
      (let [m (some-> node :children second :children first meta)]
        (api/reg-finding! (assoc m :message "keyword should be fully qualified!"
                                 :type :re-frame/keyword))))))
```

Config:
```clojure
{:linters {:re-frame/keyword {:level :warning}}
 :hooks {:analyze-call {re-frame.core/dispatch hooks.re-frame/dispatch}}}
```

### Accessing Config in Hooks

```clojure
{:linters {:foo/lint-bar {:level :warning
                          :lint [:a :b]}}
 :hooks {:analyze-call {foo/bar hooks.foo/bar}}}
```

```clojure
(ns hooks.foo
  (:require [clj-kondo.hooks-api :as api]))

(defn bar [{:keys [node config]}]
  (let [linter-params (-> config :linters :foo/lint-bar :lint)]
    (when (warn? linter-params)
      (api/reg-finding! (assoc (meta node)
                               :message "warning message!"
                               :type :foo/lint-bar)))))
```

## macroexpand

The `:macroexpand` hook expands s-expression representations using a macro in
config. After expansion, clj-kondo coerces back to rewrite-clj nodes. Easier
than `:analyze-call` but loses location precision.

### Example

Script with problematic macro:
```clojure
(ns script)
(def sh (js/require "shelljs"))
(defmacro $ [op & args]
  (list* (symbol (str "." op)) 'sh args))
($ which "git") ;; which is unresolved
```

Place macro in `.clj-kondo/script.clj`:
```clojure
(ns script)
(defmacro $ [op & args]
  (list* (symbol (str "." op)) 'sh args))
```

Config:
```clojure
{:hooks {:macroexpand {script/$ script/$}}}
```

### Subtleties

- Put macroexpansion code in a file/namespace matching the original macro's namespace.
  E.g. macro in namespace `bar` → `.clj-kondo/bar.clj`, namespace `my-app.bar` → `.clj-kondo/my_app/bar.clj`.
- Fully qualify aliases in config macros instead of using namespace aliases.

## Tips and Tricks

### Debugging

- Use `println`/`prn` in hooks. `(prn (api/sexpr node))` to inspect nodes.
- Pass `--debug` to clj-kondo for additional checks (not in production).

### Ignoring Warnings in Generated Nodes

```clojure
(vary-meta new-node assoc :clj-kondo/ignore [:discouraged-var])
```

### Performance

- Split hooks across files/namespaces if different hooks are used in different files.
- Use `require` for shared code in a library namespace.
- Use `time` macro for measurement.

### Disrecommend Usage Example

`.clj-kondo/config.edn`:
```clojure
{:hooks {:analyze-call {clojure.core/eval org.acme.not-recommended/hook}}
 :linters {:org.acme/not-recommended {:level :error}}}
```

`.clj-kondo/org/acme/not_recommended.clj`:
```clojure
(ns org.acme.not-recommended
  (:require [clj-kondo.hooks-api :as api]))

(defn hook [{:keys [node]}]
  (let [name (str (first (:children node)))]
    (api/reg-finding!
     (assoc (meta node)
            :message (format "Please don't use %s" name)
            :type :org.acme/not-recommended))))
```

## Exporting Hooks with Libraries

To refer to exported config within the same project:
```clojure
{:config-paths ["../resources/clj-kondo.exports/org.your/your.lib"]}
```

## More Examples

- [coffi defcfn hook](https://github.com/IGJoshua/coffi/blob/master/resources/clj-kondo.exports/org.suskalo/coffi/hooks/coffi.clj)
- [clj-kondo config project](https://github.com/clj-kondo/config) — community hooks for popular libraries
- [re-frame subscription analysis](https://github.com/yannvanhalewyn/analyze-re-frame-usage-with-clj-kondo)
