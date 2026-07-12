" cgv: populate `:Git revise <sha>` for the commit under the cursor, in any
" fugitive commit context.

if exists('g:loaded_fugitive_revise')
  finish
endif
let g:loaded_fugitive_revise = 1

function! s:ReviseArgument() abort
  let object = matchstr(@%, '\c^fugitive://.\{-\}//\zs\x\{40,\}')
  if !empty(object)
    return object
  elseif &filetype ==# 'fugitive'
    return matchstr(getline('.'), '^\%(\%(\x\x\x\)\@!\l\+\s\+\)\=\zs[0-9a-f]\{4,\}\ze \|^\%(Merge\|Rebase\|Upstream\|Pull\|Push\): \zs\S\+')
  else
    return matchstr(getline('.'), '\S\@<!\x\{4,\}\S\@!')
  endif
endfunction

" Leaves the command line open (no trailing <CR>) so flags can be appended.
augroup fugitive_revise
  autocmd!
  autocmd User FugitiveIndex,FugitivePager,FugitiveObject
        \ nnoremap <buffer> cgv :<C-U>Git revise <C-R>=<SID>ReviseArgument()<CR>
augroup END
