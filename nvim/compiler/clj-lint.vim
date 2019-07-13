" if exists("current_compiler")
"   finish
" endif
" let current_compiler = "mine"

let s:errorformat = '%f:%l:%c: Parse %t%*[^:]: %m,%f:%l:%c: %t%*[^:]: %m'
execute 'CompilerSet errorformat='.escape(s:errorformat, ' \|"')

let s:prg='joker --lint % || (clj-kondo --lint %; return 1) && clj-kondo --lint %'
execute 'CompilerSet makeprg='.escape(s:prg, ' \|"')