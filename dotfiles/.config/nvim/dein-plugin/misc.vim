" call my_plugin#add('ap/vim-css-color')
call my_plugin#add('norcalli/nvim-colorizer.lua')

function! Hook_post_source_colorizer()
  lua require'colorizer'.setup()
  lua COLORIZER_SETUP_HOOK()
endf

" A few plugins require this plugin in order to make their
" own operators.  More than just those in operators.
call my_plugin#add('kana/vim-operator-user')

function! Hook_post_source_operator_user()
    doautocmd User OperatorUserDefine
endf

" This is both a utility and dependency of a few plugins
" (fugitive, rhubarb, jack-in)
call my_plugin#add('tpope/vim-dispatch')

" seed the dispatch compilers so that later groups can set
" keys in it
let g:dispatch_compilers = {}

" This provides dispatch with a neovim :terminal based
" interface. This means that `:Start` will open a terminal
" in a tab.
" call my_plugin#add('radenling/vim-dispatch-neovim')

" This plugin extends the functionality of `.`.  I added it
" initially for support with >) from vim-sexp, but
" vim-sneak and many others also use it.
call my_plugin#add('tpope/vim-repeat')

" Some plugins require this in order to figure out the
" contextual filetype (e.g. in a [source] block in
" asciidoc, or in ```clojure in markdown) Plug
" Used by:
" - deoplete
" call my_plugin#add('Shougo/context_filetype.vim')

call my_plugin#add('tpope/vim-sleuth')

call my_plugin#add('lepture/vim-jinja')

call my_plugin#add('tpope/vim-scriptease')

call my_plugin#add('ziglang/zig.vim') 

call my_plugin#add('tpope/vim-speeddating')

let g:textobj_diff_no_default_key_mappings = 1
call my_plugin#add('kana/vim-textobj-diff')
