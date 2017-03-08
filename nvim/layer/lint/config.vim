let g:clojure_check_bin = '/home/dominic/src/github.com/SevereOverfl0w/clojure-check/clojure-check'
function! s:ClojureHost()
  return fireplace#client().connection.transport.host
endfunction

function! s:ClojurePort()
  return fireplace#client().connection.transport.port
endfunction

function! ClojureCheck(buffer)
  try
    return g:clojure_check_bin.' '.s:ClojureHost().':'.s:ClojurePort().' '.fireplace#ns(a:buffer)
  catch /Fireplace/
    return ''
  endtry
endfunction

call ale#linter#Define('clojure', {
\   'name': 'clojure_check',
\   'executable': g:clojure_check_bin,
\   'command_callback': 'ClojureCheck',
\   'callback': 'ale#handlers#HandleUnixFormatAsError',
\})

nmap ]a <Plug>(ale_next_wrap)
nmap [a <Plug>(ale_previous_wrap)
