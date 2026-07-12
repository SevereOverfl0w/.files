if exists('g:my_plugin_loaded_ctrlp')
  finish
endif

call my_plugin#add('ctrlpvim/ctrlp.vim')

let g:ctrlp_map = ''

nnoremap <Leader>jf <Cmd>CtrlPMixed<CR>
nnoremap <Leader>b <Cmd>CtrlPBuffer<CR>
nnoremap <Leader>B <Cmd>CtrlPLine<CR>

for dirmap in get(g:, 'dirs_of_interest', [])
  execute 'nnoremap '. dirmap.prefix . 'f <cmd>CtrlP ' . dirmap['directory'] .'<CR>'
endfor
