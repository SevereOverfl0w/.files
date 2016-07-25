" These make more sense to me
nmap <buffer> gs <Plug>FireplaceDjump
nmap <buffer> gvs <Plug>FireplaceDsplit

" TODO: Hammock an argument for input?
function! RunRepl(cmd)
  tabnew
  if executable('rlwrap')
    call termopen('rlwrap ' . a:cmd)
  else
    call termopen(a:cmd)
  endif
  set syntax=clojure
  tabprevious
endfunction

" TODO: Take an optional arg for alternative tasks
command! -buffer Boot :call RunRepl("boot cider dev")
command! -buffer Lein :call RunRepl("lein repl")
command! -buffer Figwheel :call RunRepl("lein figwheel")")

" TODO: if/else this,and warn
command! -buffer Cljsbuild :Dispatch lein cljsbuild once

if !exists('b:dev_ns')
  let b:dev_ns = 'dev'
endif

" Stuart Sierra's reloaded workflow
nnoremap <buffer> <localleader>go :call fireplace#echo_session_eval('(go)', {'ns': b:dev_ns})<CR>
nnoremap <buffer> <localleader>rs :call fireplace#echo_session_eval('(reset)', {'ns': b:dev_ns})<CR>
nnoremap <buffer> <localleader>rf :call fireplace#echo_session_eval('(clojure.tools.namespace.repl/refresh)', {'ns': 'user'})<CR>
nnoremap <buffer> <localleader>ra :call fireplace#echo_session_eval('(clojure.tools.namespace.repl/refresh-all)', {'ns': 'user'})<CR>

function! s:EvalIn(args)
  let sargs = split(a:args)
  call fireplace#echo_session_eval(join(sargs[1:-1]), {'ns': sargs[0]})
endfunction

command! -buffer -nargs=* EvalIn :exe s:EvalIn(<q-args>)

setlocal foldmethod=syntax
