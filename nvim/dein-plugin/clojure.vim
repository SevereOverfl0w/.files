" Clojure {{{

" Update the static files for clojure from it's upstream,
" this includes fixes like indenting #() properly.
call dein#add('guns/vim-clojure-static')

" This plugin allows you to manipulate sexp (clojure
" parens) in magical ways.
call dein#add('guns/vim-sexp')

" By default == has a maximum number of lines to prevent
" hanging. Disable that, because I'm happy to wait when I
" want this.
let g:clojure_maxlines = 0

" Unfortunately the default mappings for vim-sexp are hard
" to press (lots of ctrl & alt), but tpope has us covered:
call dein#add('tpope/vim-sexp-mappings-for-regular-people')

" FiREPLace is a plugin for integrating with a Clojure
" nREPL.
call dein#add('tpope/vim-fireplace')
" Disable auto-nashorn
let g:fireplace_cljs_repl = ''

" REPLant is a plugin for enhancing your REPL experience
" with vim I develop this, so I've selected my src dir.
" Plug '~/src/github.com/SevereOverfl0w/replant'
call dein#add('~/src/github.com/SevereOverfl0w/replant')

" A plugin for managing nREPL middleware and starting the
" nREPL.
call dein#add('~/src/github.com/clojure-vim/vim-jack-in')

function! Hook_post_source_jack_in()
let g:jack_in_injections['cider/piggieback'] =
    \  {'version': '0.4.2-SNAPSHOT',
    \   'middleware': 'cider.piggieback/wrap-cljs-repl'}

let g:jack_in_injections['com.gfredericks/debug-repl'] =
      \ {'version': '0.0.11-SNAPSHOT',
      \  'middleware': 'com.gfredericks.debug-repl/wrap-debug-repl'}
endf

" async-clj-omni is an auto-completion plugin for
" deoplete.

" call dein#add('clojure-vim/async-clj-omni',
"       \ {'depends': ['deoplete.nvim']})

" call dein#add('~/src/github.com/clojure-vim/async-clj-omni',
"       \ {'depends': ['deoplete.nvim']})


" call dein#add('~/src/github.com/clojure-vim/async-clj-omni',
"       \ {'depends': ['asyncomplete.vim']})

" https://github.com/prabirshrestha/asyncomplete.vim/issues/117
" inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() . "\<CR>" : "\<CR>"

" augroup ClojureLint
" autocmd!
" autocmd BufWritePost *.clj silent Make
" augroup END
" }}}