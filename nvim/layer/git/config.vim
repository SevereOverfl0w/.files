let g:gitgutter_map_keys = 0

nnoremap <Leader>gv :GV
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>gf :Gpull<CR>
nnoremap <Leader>gW :Gwrite<CR>:Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gD :Gvdiff<CR>
nnoremap <Leader>gb :Gblame<CR>

nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk
