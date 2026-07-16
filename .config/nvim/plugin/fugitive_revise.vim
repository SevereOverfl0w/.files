" Commit-under-cursor maps for fugitive (status/pager/object) and Flog graphs:
"   cgv  populate `:Git revise <sha>`  (left open so flags can be appended)
"   crv  populate `:Review <sha>`      (left open so flags can be appended)
"   chW  `:Git history reword <sha>`   (runs immediately, like fugitive's rw)

if exists('g:loaded_fugitive_revise')
  finish
endif
let g:loaded_fugitive_revise = 1

" Resolve the commit under the cursor, auto-detecting the buffer context:
" Flog graph, fugitive status, a fugitive:// object, or a pager temp file.
function! s:CommitArgument() abort
  if &filetype ==# 'floggraph'
    " Flog maps each line to a commit; GetAtLine returns {} off-commit.
    return get(flog#floggraph#commit#GetAtLine(), 'hash', '')
  endif
  let object = matchstr(@%, '\c^fugitive://.\{-\}//\zs\x\{40,\}')
  if !empty(object)
    return object
  elseif &filetype ==# 'fugitive'
    return matchstr(getline('.'), '^\%(\%(\x\x\x\)\@!\l\+\s\+\)\=\zs[0-9a-f]\{4,\}\ze \|^\%(Merge\|Rebase\|Upstream\|Pull\|Push\): \zs\S\+')
  else
    return matchstr(getline('.'), '\S\@<!\x\{4,\}\S\@!')
  endif
endfunction

function! s:Maps() abort
  nnoremap <buffer> cgv :<C-U>Git revise <C-R>=<SID>CommitArgument()<CR>
  nnoremap <buffer> crv :<C-U>Review <C-R>=<SID>CommitArgument()<CR>
  nnoremap <buffer><silent> chW :<C-U>Git history reword <C-R>=<SID>CommitArgument()<CR><CR>
endfunction

" Same contexts as fugitive's own commit-under-cursor maps: non-modifiable
" buffers where a SHA sits under the cursor.
augroup fugitive_revise
  autocmd!
  autocmd User FugitiveIndex,FugitivePager,FugitiveObject call s:Maps()
  autocmd FileType floggraph call s:Maps()
augroup END
