" These make more sense to me
nnoremap <buffer> gs :<C-u>exe "norm \<Plug>FireplaceDjump"<CR>zOzz:call halo#run({'shape': 'cross2'})<CR>
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

function! BootRepl(...)
  if a:0 > 0 && a:1 != ''
    call RunRepl('boot cider '.join(a:000, ' '))
  else
    call RunRepl('boot cider dev')
  endif
endfunction

" TODO: Take an optional arg for alternative tasks
command! -nargs=* -buffer Boot :exe BootRepl(<q-args>)
command! -buffer Lein :call RunRepl("lein repl")
command! -buffer Figwheel :call RunRepl("lein figwheel")")

" TODO: if/else this,and warn
command! -buffer Cljsbuild :Dispatch lein cljsbuild once

function! s:CiderRefresh()
  " TODO: Collect reloading key from all messages, just in case
  let refresh = fireplace#message({'op': 'refresh'})
  echon 'reloading: (' join(refresh[0]['reloading'], ' ') ')'
endfunction

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

" Stuart Sierra's reloaded workflow
nnoremap <buffer> <localleader>go :call fireplace#echo_session_eval('(go)', {'ns': <SID>FindDevNamespace()})<CR>
nnoremap <buffer> <localleader>rs :call fireplace#echo_session_eval('(reset)', {'ns': <SID>FindDevNamespace()})<CR>
nnoremap <buffer> <localleader>ra :call fireplace#echo_session_eval('(reset-all)', {'ns': <SID>FindDevNamespace()})<CR>

nnoremap <buffer> <localleader>ff :call fireplace#echo_session_eval('(clojure.tools.namespace.repl/refresh)', {'ns': 'user'})<CR>
nnoremap <buffer> <localleader>fa :call fireplace#echo_session_eval('(clojure.tools.namespace.repl/refresh-all)', {'ns': 'user'})<CR>
nnoremap <buffer><silent> <localleader>cf :call <SID>CiderRefresh()<CR>

function! s:EvalIn(args)
  let sargs = split(a:args)
  call fireplace#echo_session_eval(join(sargs[1:-1]), {'ns': sargs[0]})
endfunction

command! -buffer -nargs=* EvalIn :exe s:EvalIn(<q-args>)

if expand('%:t') == 'build.boot'
  let b:fireplace_ns = 'boot.user'
endif

setlocal foldmethod=syntax
