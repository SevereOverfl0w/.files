setlocal makeprg=lit\ %
if expand('%:t') ==# 'init.vim.lit'
  let b:nrrw_aucmd_create='set ft=vim | doautocmd BufRead'
endif

