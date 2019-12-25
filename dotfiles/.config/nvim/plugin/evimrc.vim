" Since reading learn vimscript the hard way, I always keep
" these mappings available in some form.  The size was
" wrong when doing `:topleft :vsplit $MYVIMRC`, hence the
" function to make sure it's done hard & right.
function! Evimrc()
  topleft vsplit $MYVIMRC
  vertical resize 61
  setlocal winfixwidth
endf

noremap <Leader>ve :call Evimrc()<CR>
noremap <Leader>jv :call Evimrc()<CR>
" Unfortunately I can't think of a way to make this fit
" into other cute mnemonics.
noremap <Leader>vs :source $MYVIMRC<CR>

