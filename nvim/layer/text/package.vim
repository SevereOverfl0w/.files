function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
    UpdateRemotePlugins
  endif
endfunction

Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
