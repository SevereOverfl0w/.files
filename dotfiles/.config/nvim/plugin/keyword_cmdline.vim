" Simple plugin to reset iskeyword when in cmdline mode.

let s:saved_iskeyword=0

function s:reset_iskeyword()
  let s:saved_iskeyword=&iskeyword
  set iskeyword&
endf

function s:restore_iskeyword()
  if s:saved_iskeyword isnot 0
    let &iskeyword=s:saved_iskeyword
    let s:saved_iskeyword=0
  endif
endf

augroup resetiskeyword
  autocmd!
  autocmd CmdlineEnter * call <SID>reset_iskeyword()
  autocmd CmdlineLeave * call <SID>restore_iskeyword()
augroup END
