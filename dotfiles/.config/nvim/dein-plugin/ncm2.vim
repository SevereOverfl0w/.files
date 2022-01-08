if exists('g:my_plugin_loaded_ncm2')
  finish
end

call my_plugin#add('ncm2/ncm2')
call my_plugin#add('roxma/nvim-yarp')
call my_plugin#add('ncm2/float-preview.nvim')

" enable ncm2 for all buffers
function Hook_post_source_ncm2()
  augroup activate_ncm2
    au!
    autocmd BufEnter * call ncm2#enable_for_buffer()
  augroup END

  " IMPORTANT: :help Ncm2PopupOpen for more information
  set completeopt=noinsert,menuone,noselect

  au User Ncm2Plugin call ncm2#register_source({
          \ 'name' : 'todo',
          \ 'priority': 9,
          \ 'scope': ['todo'],
          \ 'mark': 'todo',
          \ 'word_pattern': '[+@]\S+',
          \ 'complete_length': -1,
          \ 'complete_pattern': '[+@]',
          \ 'on_complete': ['ncm2#on_complete#omni', 'todo#Complete'],
          \ })

  au User Ncm2Plugin call ncm2#register_source({
      \ 'name' : 'zk',
      \ 'priority': 9,
      \ 'scope': ['markdown'],
      \ 'mark': 'ZK',
      \ 'complete_pattern': ['\[\[', '#'],
      \ 'on_complete': 'ncm2#on_complete#lsp',
      \ })
endfunction

