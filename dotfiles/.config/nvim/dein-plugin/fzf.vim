if exists('g:my_plugin_loaded_fzf')
  finish
endif

call my_plugin#add('junegunn/fzf', {'merged': 0})
call my_plugin#add('junegunn/fzf.vim')

" `rg` respects gitignore anyway, so use a version of the
" default command without the direct git integration.
let $FZF_DEFAULT_COMMAND = "fd --type file --hidden --follow --exclude .git --exclude .stversions --exclude '.clj-kondo/.cache' || rg --files --hidden --follow -g '!.git' -g '!.stversions' || ag -l -g \"\" || find ."

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
nnoremap <Leader>jF :<C-U>GFiles?<CR>

for dirmap in get(g:, 'dirs_of_interest', [])
  execute 'nnoremap '. dirmap.prefix . 'f <cmd>FZF '. dirmap['directory'] .'<CR>'
endfor

noremap <leader>b <Cmd>Buffers<cr>
noremap <leader>B <Cmd>BLines<cr>
noremap <leader>L <Cmd>Lines<cr>

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

function s:tabName(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    return bufname(buflist[winnr - 1])
endfunction

function! s:jumpToTab(line)
    let pair = split(a:line, ' ')
    let cmd = pair[0].'gt'
    execute 'normal' cmd
endfunction

command! Tabs :call fzf#run({
\   'source':  reverse(map(range(1, tabpagenr('$')), 'v:val." "." ".<SID>tabName(v:val)')),
\   'sink':    function('<sid>jumpToTab'),
\   'down':    tabpagenr('$') + 2
\ })
