if exists('g:my_plugin_loaded_fzf')
  finish
endif

call my_plugin#add('junegunn/fzf', {'merged': 0})
call my_plugin#add('junegunn/fzf.vim')

" `rg` respects gitignore anyway, so use a version of the
" default command without the direct git integration.
let $FZF_DEFAULT_COMMAND = "fd --type file ---hidden --follow --exclude .git --exclude .stversions || rg --files --hidden --follow -g '!.git' -g '!.stversions' || ag -l -g \"\" || find ."

" The default colors look wrong
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Keyword'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Keyword'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Question'],
  \ 'pointer': ['fg', 'MatchParen'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header': ['fg', 'Comment'] }
" jf = jump file
nnoremap <Leader>jf :<C-U>FZF<CR>

for dirmap in get(g:, 'dirs_of_interest', [])
  execute 'nnoremap '. dirmap.prefix . 'f <cmd>FZF '. dirmap['directory'] .'<CR>'
endfor

noremap <leader>b <Cmd>Buffers<cr>
noremap <leader>B <Cmd>BLines<cr>
noremap <leader>L <Cmd>Lines<cr>

if has('nvim') && exists('&winblend') && &termguicolors

let g:fzf_layout = { 'window': 'call FloatingFZF()' }
  if exists('g:fzf_colors.bg')
    call remove(g:fzf_colors, 'bg')
  endif

  function! FloatingFZF()
    let buf = nvim_create_buf(v:false, v:true)
    call setbufvar(buf, '&signcolumn', 'no')

    let height = &lines - 3
    let width = float2nr(&columns - (&columns * 2 / 10))
    let col = float2nr((&columns - width) / 2)

    let opts = {
          \ 'relative': 'editor',
          \ 'row': 1,
          \ 'col': col,
          \ 'width': width,
          \ 'height': height
          \ }

    let win = nvim_open_win(buf, v:true, opts)
    call setwinvar(win, '&number', 0)
  endfunction
endif
