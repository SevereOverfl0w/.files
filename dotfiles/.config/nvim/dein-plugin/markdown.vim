call my_plugin#add('plasticboy/vim-markdown')

let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_autowrite = 1
let g:vim_markdown_folding_style_pythonic = 1

call my_plugin#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
      \ 'build': 'sh -c "cd app && yarn install"' })
