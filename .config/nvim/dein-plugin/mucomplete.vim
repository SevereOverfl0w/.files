if exists('g:my_plugin_loaded_mucomplete')
  finish
end

call my_plugin#add('lifepillar/vim-mucomplete')
let g:mucomplete#enable_auto_at_startup = 1
