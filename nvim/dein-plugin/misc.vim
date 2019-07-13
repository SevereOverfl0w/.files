call dein#add('ap/vim-css-color')

" A few plugins require this plugin in order to make their
" own operators.  More than just those in operators.
call dein#add('kana/vim-operator-user')

" This is both a utility and dependency of a few plugins
" (fugitive, rhubarb, jack-in)
" call dein#add('tpope/vim-dispatch')
call dein#add('~/src/github.com/tpope/vim-dispatch')

" seed the dispatch compilers so that later groups can set
" keys in it
let g:dispatch_compilers = {}

" This provides dispatch with a neovim :terminal based
" interface. This means that `:Start` will open a terminal
" in a tab.
" call dein#add('radenling/vim-dispatch-neovim')

" This plugin extends the functionality of `.`.  I added it
" initially for support with >) from vim-sexp, but
" vim-sneak and many others also use it.
call dein#add('tpope/vim-repeat')

" Some plugins require this in order to figure out the
" contextual filetype (e.g. in a [source] block in
" asciidoc, or in ```clojure in markdown) Plug
" Used by:
" - deoplete
" call dein#add('Shougo/context_filetype.vim')

call dein#add('tpope/vim-sleuth')

call dein#add('lepture/vim-jinja')

call dein#add('tpope/vim-scriptease')
