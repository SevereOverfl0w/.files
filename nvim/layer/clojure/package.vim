function! RefactorDoRemote(arg)
  UpdateRemotePlugins
endfunction

" Lispy plugins
Plug 'guns/vim-sexp' " Attempt to strip down?
Plug 'luochen1990/rainbow'
" Clojure plugins
Plug 'tpope/vim-fireplace'
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-clojure-highlight'

Plug 'neovim/node-host'
Plug 'snoe/clj-refactor.nvim', {'do': function('RefactorDoRemote')}

" TODO: Move to completion layer?
Plug 'SevereOverfl0w/async-clj-omni'
