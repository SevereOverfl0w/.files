if exists('g:my_plugin_loaded_fzf')
  finish
endif

" This loads fzf from my filesystem.  I could perhaps
" have some check for existence, and fall back otherwise,
" but I don't want to.
" call dein#add('junegunn/fzf')
call dein#add('/usr/share/vim/vimfiles')
call dein#add('junegunn/fzf.vim')

" `rg` respects gitignore anyway, so use a version of the
" default command without the direct git integration.
let $FZF_DEFAULT_COMMAND = "fd --type file ---hidden -follow --exclude .git --exclude .stversions | rg --files --hidden --follow -g '!.git' -g '!.stversions' || ag -l -g \"\" || find ."

" The default colors look wrong
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Visual'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Visual'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Question'],
  \ 'pointer': ['fg', 'MatchParen'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header': ['fg', 'Comment'] }
" jf = jump file
nnoremap <Leader>jf :<C-U>FZF<CR>
nnoremap <leader>wf :<C-U>FZF ~/doc<CR>

noremap <leader>b <Cmd>Buffers<cr>
noremap <leader>B <Cmd>BLines<cr>
noremap <leader>L <Cmd>Lines<cr>
