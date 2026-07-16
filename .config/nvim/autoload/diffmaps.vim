" Buffer-local hunk/file text-object maps, shared by the diff and gitcommit
" ftplugins. Call diffmaps#apply() from each.
function! diffmaps#apply() abort
  map <buffer> [c <Plug>(textobj-diff-hunk-p)
  map <buffer> ]c <Plug>(textobj-diff-hunk-n)

  map <buffer> [/ <Plug>(textobj-diff-file-p)
  map <buffer> [m <Plug>(textobj-diff-file-p)

  map <buffer> ]/ <Plug>(textobj-diff-file-n)
  map <buffer> ]m <Plug>(textobj-diff-file-n)
endfunction
