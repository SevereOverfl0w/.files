" tcomment is pretty solid, works well with motions and
" "gcc" does what I mean. Unfortunately it doesn't support
" context filetypes very well, so I'm looking at how I can
" change that, caw.vim does, but doesn't work well with
" motions.

call my_plugin#add('tomtom/tcomment_vim')

function! Hook_add_tcomment()
  " I really don't like the insert-mode mappings it creates:
  let g:tcomment_mapleader1 = ''
  let g:tcomment_mapleader2 = ''
endf

function! Hook_post_source_tcomment()
  " Integrate tcomment with terraform
  call tcomment#type#Define('terraform', '# %s')
  call tcomment#type#Define('terraform_block', '/* %s */' )
  call tcomment#type#Define('terraform_inline', '/* %s */' )
endf
