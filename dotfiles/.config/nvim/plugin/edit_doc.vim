function! FindDocForFile()
  let l:dirs_to_check = keys(g:dir_to_doc)
  for dir in l:dirs_to_check
      let reldir = substitute(expand('%:p'), dir . '/', '', '')
      if reldir != expand('%:p')
            \ && (findfile(reldir, dir) !=# '' || finddir(reldir, dir) !=# '')
          return g:dir_to_doc[dir]
      endif
  endfor
  throw 'No matching directory found in '.join(l:dirs_to_check, ',')
endf

" TODO: Pick which binding I actually use and delete the rest.
cabbr <expr> d& FindDocForFile()
cnoremap <expr> <C-R><C-D> FindDocForFile()
command! Doc exe 'vsplit ' . FindDocForFile()
nnoremap <Leader>dd <Cmd>Doc<CR>
