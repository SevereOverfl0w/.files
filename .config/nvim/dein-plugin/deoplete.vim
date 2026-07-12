if exists('g:my_plugin_loaded_deoplete')
  finish
endif

" Deoplete provides asyncronous as-you-type completions
call my_plugin#add('Shougo/deoplete.nvim')

" It isn't enabled by default, so start it up
let g:deoplete#enable_at_startup = 1

" I set some deoplete patterns later on for filetypes
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.#]*'
let g:deoplete#omni_patterns = {}

function! Hook_post_source_deoplete()
  " TODO: This doesn't seem to cover all possible cases where
  " terraform can do completions.
  call deoplete#custom#var('omni', 'input_patterns', {
      \ 'terraform': '[^ *\t"{=$]\w*',
      \})
endf
