let g:rainbow_active = 1
let g:clojure_special_indent_words = 'deftype,defrecord,reify,proxy,extend-type,extend-protocol,letfn,defcomponent'
let g:clojure_maxlines = 0
setlocal lispwords+=go-loop,try-n-times,fdef

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.#]*'

if !exists('g:test_terminal_id')
  let g:test_terminal_id = -2
endif

function! s:GetOrMakeTerm()
  if g:test_terminal_id <= 0 || jobwait([g:test_terminal_id], 0)[0] <= -2
    botright new
    resize 7
    set wfh
    let g:test_terminal_id = termopen('boot repl -c')
  endif
  return g:test_terminal_id
endfunction

function! s:RunAllMyTests(myarg)
  " call jobsend(s:GetOrMakeTerm(), ["(require 'dev) (dev/run-all-my-tests)", ""])
  call jobsend(s:GetOrMakeTerm(), ["(require 'eftest.runner) (eftest.runner/run-tests (eftest.runner/find-tests " . a:myarg . ") {:multithread? false})", ""])
endfunction

command! -nargs=* RunDevTests :call s:RunAllMyTests(<q-args>)

function! s:ReplDoc(symbol)
  exec "Eval (clojure.repl/doc " a:symbol ")"
endfunction

nnoremap <silent> RK :call <SID>ReplDoc(expand('<cword>'))<CR>
