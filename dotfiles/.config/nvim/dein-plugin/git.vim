" Gitgutter provides a few functions:
" - Show where files have changed via gutter icons
" - Text object for hunks
" - Staging / unstaging hunks
call my_plugin#add('airblade/vim-gitgutter')

" Leave my sign column alone!
let g:gitgutter_override_sign_column_highlight = 0

function! Hook_add_gitgutter()
  " Disable gitgutter mappings, I can take care of that, thank you!
  let g:gitgutter_map_keys = 0
  " Apparently I can integrate with ripgrep really easily, and ripgrep is
  " awesome.
  if executable('rg')
    let g:gitgutter_grep = 'grep'
  endif

  " Mapping for jumping between hunks
  nmap ]h <Plug>(GitGutterNextHunk)
  nmap [h <Plug>(GitGutterPrevHunk)

  nmap <Leader>gff <cmd>GitGutterFold<CR>

  " Stage the hunk under the cursor
  nmap <Leader>ghs <Plug>(GitGutterStageHunk)
  " Show the diff of the hunk at cursor.  I'm not convinced this is actually
  " useful yet, but time will tell.
  nmap <Leader>ghp <Plug>(GitGutterPreviewHunk)
  " Discard the hunk under the cursor.  Useful for getting rid of println code.
  nmap <Leader>ghu <Plug>(GitGutterUndoHunk)
  " This is a text object referring to the current hunk
  omap ih <Plug>(GitGutterTextObjectInnerPending)
  omap ah <Plug>(GitGutterTextObjectOuterPending)
  xmap ih <Plug>(GitGutterTextObjectInnerVisual)
  xmap ah <Plug>(GitGutterTextObjectOuterVisual)
endf
" }}}

" FuGITive is a git wrapper for vim.  The interactive staging features are
" amazing.
call my_plugin#add('tpope/vim-fugitive')

function! Hook_post_source_fugitive()
  for cmd in ['Gremove']
    exe 'delcommand ' . cmd
  endfor
endf
" The official integration between fugitive and github
call my_plugin#add('tpope/vim-rhubarb')
" Integration with gitlab
call my_plugin#add('shumphrey/fugitive-gitlab.vim')
" Conflicted is a plugin for simplifying merges
call my_plugin#add('christoomey/vim-conflicted')

function! Hook_post_source_conflicted()
  autocmd User Flags call Hoist("window", "ConflictedVersion")
endf

function! MyMerger()
    set tabline=%!ConflictedTabline()
    Merger
endfunction

" This list is butched from:
" https://www.reddit.com/r/vim/comments/21f4gm/best_workflow_when_using_fugitive/cgciltz/

" Stage file
nnoremap <Leader>ga :Git add %:p<CR><CR>
" Open status buffer
nnoremap <Leader>gs :Git<CR>
" Commit normally
nnoremap <Leader>gc :Git commit -v -q<CR>
" Commit and stage current file (if you commit only)
nnoremap <Leader>gt :Git commit -v -q %:p<CR>
" Open current file on the index
nnoremap <Leader>ge :Gedit<CR>
" Like `:edit` but against the index
nnoremap <Leader>gr :Gread<CR>
" Like `:write` but against the index (stage file,
" basically)
nnoremap <Leader>gw :Gwrite<CR><CR>
" Open log for current file
nnoremap <Leader>gl :silent! Gclog<CR>:bot copen<CR>
" git-grep version of :grep
nnoremap <Leader>gp :Ggrep<Space>
" Rename current buffer and do `git mv`
nnoremap <Leader>gm :GMove<Space>
" Pass through to git
nnoremap <Leader>gb :Git branch<Space>
nnoremap <Leader>go :Git checkout<Space>
" Pull & push
nnoremap <Leader>gps :Dispatch! git push<CR>
nnoremap <Leader>gpl :Dispatch! git pull<CR>

nnoremap <Leader>gB :.Gbrowse<CR>
" }}}

call my_plugin#add('junegunn/gv.vim')

nnoremap <Leader>gv :GV<CR>
nnoremap <Leader>gLL :GV!<CR>

function! SetGitBase(base)
  let g:gitgutter_diff_base = a:base
endfunction

command! -nargs=0 GitListChanges :exec 'Git difftool --name-status ' . g:gitgutter_diff_base

function! ToggleDiff()
  if &diff
    for win in range(1, winnr('$'))
      let bufnr = winbufnr(win)
      if getwinvar(win, '&diff') && (getbufvar(bufnr, 'fugitive_type') == 'blob' || getbufvar(bufnr, '&buftype') == 'nofile')
        call nvim_win_close(win_getid(win), 0)
      endif
    endfor
  else
    if FugitiveGitDir() == ''
      GitGutterDiffOrig
    else
      exec 'Gvdiffsplit! ' . get(g:, 'gitgutter_diff_base', '')
    end
  endif
endfunction

nnoremap <leader>gd <Cmd>call ToggleDiff()<CR>

function Review(base)
  let g:gitgutter_diff_base = a:base
  GitGutterQuickFix | copen | cfirst
  exec 'Git! lg ' . a:base . '...HEAD'
endfunction

command! -nargs=1 Review call Review(<q-args>)
