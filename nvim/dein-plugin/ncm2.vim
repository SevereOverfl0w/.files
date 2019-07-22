if exists('g:my_plugin_loaded_ncm2')
  finish
end

call my_plugin#add('ncm2/ncm2')
call my_plugin#add('roxma/nvim-yarp')

" enable ncm2 for all buffers
augroup activate_ncm2
  au!
  autocmd BufEnter * call ncm2#enable_for_buffer()
augroup END

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect,preview
