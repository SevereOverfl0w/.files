" vim:fdm=marker:tw=58

let g:my_plugin_loaded_deoplete = 1
let g:my_plugin_loaded_asyncomplete = 1
" let g:loaded_dispatch_kitty = 1

let g:dirs_of_interest = [
      \ {'directory': '~/doc',
      \  'prefix': '<Leader>w'},
      \ {'directory': '~/.config/nvim',
      \  'prefix': '<Leader>v'}
      \ ]

let g:dev_overrides = {
      \ 'SevereOverfl0w/replant': '~/src',
      \ 'clojure-vim/vim-jack-in': '~/src',
      \ 'tpope/vim-dispatch': '~/src',
      \}

call my_plugin#run()
