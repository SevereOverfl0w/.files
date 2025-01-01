" Update the static files for clojure from it's upstream,
" this includes fixes like indenting #() properly.
call my_plugin#add('clojure-vim/clojure.vim')

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
" with vim.
call my_plugin#add('SevereOverfl0w/vim-replant')

" A plugin for managing nREPL middleware and starting the
" nREPL.
call my_plugin#add('clojure-vim/vim-jack-in')

function! Hook_post_source_jack_in()
  let g:jack_in_injections['cider/piggieback'] =
      \  {'version': '0.5.3',
      \   'middleware': 'cider.piggieback/wrap-cljs-repl'}

  let g:jack_in_injections['refactor-nrepl/refactor-nrepl']['version'] = '3.6.0'
  let g:jack_in_injections['cider/cider-nrepl']['version'] = '0.29.0'

  let g:jack_in_injections['io.dominic/nrepl-bind'] =
              \  {'version': '0.1.1',
              \   'middleware': 'io.dominic.nrepl-bind/wrap-bind'}
  " let g:jack_in_injections['io.dominic/nrepl-bind'] = {'middleware': 'io.dominic.nrepl-bind/wrap-bind'}

  if exists('*Local_Jack_In')
      call Local_Jack_In()
  endif
endf

let s:setup = []
function! s:SetupBind()
    if !fireplace#op_available('eval')
        return
    endif
    let id = fireplace#clj().Client().session.url
    if index(s:setup, id)
        let Eval = fireplace#clj().Eval
        " TODO: Changes *1, so not ideal.  Probably need to add an op to
        " nrepl-bind instead.
        call Eval("(ns io.dominic.mise.vim) (io.dominic.nrepl-bind/try-bind-vars matcher-combinators.ansi-color/*use-color*)")
        call Eval("(ns io.dominic.mise.vim) (when (resolve 'matcher-combinators.ansi-color/*use-color*) (eval '(set! matcher-combinators.ansi-color/*use-color* false)))")
        call add(s:setup, id)
    endif
endfunction

function! s:ClearTagBind()
  " Clear tag bindings set by fireplace, in favour of using LSP with a tagfunc
  nunmap <buffer> <C-]>
  nunmap <buffer> g<LeftMouse>
  " nunmap <buffer> <C LeftMouse>
  nunmap <buffer> g]
  nunmap <buffer> g<C-]>
  nunmap <buffer> <C-W>]
  nunmap <buffer> <C-W><C-]>
  nunmap <buffer> <C-W>g]
  nunmap <buffer> <C-W>g<C-]>
endfunction

augroup FireplaceCustom
    autocmd!
    autocmd FileType clojure call s:SetupBind()
    autocmd User FireplaceActivate call s:SetupBind()
    autocmd User FireplaceActivate call s:ClearTagBind()
augroup END


" async-clj-omni is an auto-completion plugin for
" clojure
call my_plugin#add('clojure-vim/async-clj-omni')

" augroup ClojureLint
" autocmd!
" autocmd BufWritePost *.clj silent Make
" augroup END
" }}}
