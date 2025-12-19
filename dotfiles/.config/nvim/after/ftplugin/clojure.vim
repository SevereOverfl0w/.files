nmap <buffer> gd <Plug>FireplaceDjump

nnoremap <leader>jV :<C-U>ReplantApropos --project --private<CR>
nmap <localleader>eF <Plug>FireplacePrint<Plug>(sexp_outer_top_list)``
"function! s:CiderRefresh()
"  " TODO: Collect reloading key from all messages, just in case
"  let refresh = fireplace#message({'op': 'refresh'})
"  echon 'reloading: (' join(refresh[0]['reloading'], ' ') ')'
"endfunction
"
"nnoremap <buffer><silent> <localleader>cf :call <SID>CiderRefresh()<CR>
function! s:FindDevNamespace()
  if !exists('b:dev_ns')
    if !exists('g:dev_ns')
      return 'dev'
    else
      return g:dev_ns
    endif
  else
    return b:dev_ns
  endif
endfunction
nnoremap <buffer> <localleader>go :call fireplace#echo_session_eval('(go)', {'ns': <SID>FindDevNamespace(), 'session': 0})<CR>
nnoremap <buffer> <localleader>drs :call fireplace#echo_session_eval('(reset)', {'ns': <SID>FindDevNamespace(), 'session': 0})<CR>
"nnoremap <buffer> <localleader>ra :call fireplace#echo_session_eval('(reset-all)', {'ns': <SID>FindDevNamespace(), 'session': 0})<CR>
"function! s:CiderRefresh()
"  " TODO: Collect reloading key from all messages, just in case
"  let refresh = fireplace#message({'op': 'refresh'})
"  echon 'reloading: (' join(refresh[0]['reloading'], ' ') ')'
"endfunction
nnoremap <buffer> <localleader>ff :call fireplace#echo_session_eval('(require ''clojure.tools.namespace.repl)(clojure.tools.namespace.repl/refresh)', {'ns': 'user', 'session': 0})<CR>
nnoremap <buffer> <localleader>fa :call fireplace#echo_session_eval('(require ''clojure.tools.namespace.repl)(clojure.tools.namespace.repl/refresh-all)', {'ns': 'user', 'session': 0})<CR>
function! s:EvalIn(args)
  let sargs = split(a:args)
  call fireplace#echo_session_eval(join(sargs[1:-1]), {'ns': sargs[0]})
endfunction

command! -buffer -nargs=* EvalIn :exe s:EvalIn(<q-args>)
if expand('%:t') ==# 'build.boot'
  let b:fireplace_ns = 'boot.user'
endif
" setlocal foldmethod=syntax
" command! -buffer RunProjectTests call fireplace#capture_test_run('(clojure.test/run-all-tests #"('.luaeval('_A:sub(2,-2)', fireplace#eval('(apply str (interpose "|" (cider.nrepl.middleware.util.namespace/loaded-project-namespaces)))')).')")', '') | copen

compiler clj-lint

nmap <LocalLeader>]d <Plug>ReplantPeekSource

setlocal lispwords+=$d,<>,$
setlocal shiftwidth=2

function! s:StacktraceExpr(expr) abort
  let expr = '(clojure.core/with-out-str (clojure.core/binding [clojure.core/*err* clojure.core/*out*] ((requiring-resolve ''clojure.repl/pst) ' . a:expr . ')))'
  let stacktrace = split(fireplace#evalparse(expr), '\n')
  let qf = fireplace#quickfix_for(stacktrace)
  call setqflist([], ' ', #{title: a:expr, items: qf})
endfunction

command! -buffer -nargs=*
        \ -complete=customlist,fireplace#eval_complete StacktraceExpr
        \ call <SID>StacktraceExpr(<q-args>)
