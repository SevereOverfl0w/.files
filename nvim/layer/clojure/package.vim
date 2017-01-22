function! RefactorDoRemote(arg)
  UpdateRemotePlugins
endfunction

" Lispy plugins
Plug 'guns/vim-sexp' " Attempt to strip down?
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'luochen1990/rainbow'
" Clojure plugins
Plug 'tpope/vim-fireplace'
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-clojure-highlight'

Plug 'neovim/node-host'
Plug 'snoe/clj-refactor.nvim', {'do': function('RefactorDoRemote')}

" TODO: Move to completion layer?
Plug 'clojure-vim/async-clj-omni'
Plug 'markwoodhall/vim-figwheel'
