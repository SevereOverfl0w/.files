; [
;   (list_lit)
;   (map_lit)
;   (vec_lit)
; ] @context

(source
  (list_lit
    value: (sym_lit
             name: (sym_name) @_name)
    value: (_) @context.final
    (#eq? @_name "ns")) @context.start) @context 

(list_lit
  value: (sym_lit
    name: (sym_name) @_name)
  (#match? @_name "^def")) @context
