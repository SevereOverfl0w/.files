if exists('g:my_plugin_loaded_asyncomplete')
  finish
endif

call my_plugin#add('prabirshrestha/asyncomplete.vim')
call my_plugin#add('ncm2/float-preview.nvim')
call my_plugin#add('yami-beta/asyncomplete-omni.vim')

au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'async_clj_omni',
    \ 'whitelist': ['clojure'],
    \ 'completor': function('async_clj_omni#sources#complete'),
    \ })

autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
\ 'name': 'omni',
\ 'allowlist': ['todo'],
\ 'completor': function('asyncomplete#sources#omni#completor'),
\ 'config': {
\   'show_source_kind': 1,
\ },
\ }))

" https://github.com/prabirshrestha/asyncomplete.vim/issues/117
inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() . "\<CR>" : "\<CR>"

let g:asyncomplete_auto_completeopt = 0

set completeopt-=preview
