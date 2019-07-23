" Update the static files for clojure from it's upstream,
" this includes fixes like indenting #() properly.
call my_plugin#add('guns/vim-clojure-static')

" This plugin allows you to manipulate sexp (clojure
" parens) in magical ways.
call my_plugin#add('guns/vim-sexp')

" By default == has a maximum number of lines to prevent
" hanging. Disable that, because I'm happy to wait when I
" want this.
let g:clojure_maxlines = 0

" Unfortunately the default mappings for vim-sexp are hard
" to press (lots of ctrl & alt), but tpope has us covered:
call my_plugin#add('tpope/vim-sexp-mappings-for-regular-people')

" FiREPLace is a plugin for integrating with a Clojure
" nREPL.
call my_plugin#add('tpope/vim-fireplace')
" Disable auto-nashorn
let g:fireplace_cljs_repl = ''

" REPLant is a plugin for enhancing your REPL experience
" with vim I develop this, so I've selected my src dir.
call my_plugin#add('SevereOverfl0w/vim-replant')

" A plugin for managing nREPL middleware and starting the
" nREPL.
call my_plugin#add('clojure-vim/vim-jack-in')

function! Hook_post_source_jack_in()
  let g:jack_in_injections['cider/piggieback'] =
      \  {'version': '0.4.1',
      \   'middleware': 'cider.piggieback/wrap-cljs-repl'}

  if exists('*Local_Jack_In')
      call Local_Jack_In()
  endif
endf

" async-clj-omni is an auto-completion plugin for
" deoplete.

call my_plugin#add('clojure-vim/async-clj-omni')

" augroup ClojureLint
" autocmd!
" autocmd BufWritePost *.clj silent Make
" augroup END
" }}}
