if exists('g:my_plugin_loaded_coc')
  finish
endif

call my_plugin#add('neoclide/coc.nvim', {'rev': 'release'})
