" Update the static files for clojure from it's upstream,
" this includes fixes like indenting #() properly.
call my_plugin#add('clojure-vim/clojure.vim')

" This plugin allows you to manipulate sexp (clojure
" parens) in magical ways.
call my_plugin#add('guns/vim-sexp', #{branch: 'master'})
" Only do sexp-aware smart paste when yanking vim-sexp objects - XXX: Undecided on the value of this yet or if I'm
" giving up sweet sweet perks.
let g:sexp_regput_fallback_source = 'o'
" When pasting into a comment or string, don't use special sexp-aware paste behaviour
let g:sexp_regput_fallback_target = 'cs'
" Pasting when on a open/closing bracket will paste into head/tail rather than "put into list", meaning [count]
" specifies number of pastes into that position, rather than position in that list.
let g:sexp_regput_bracket_is_target = 2

" By default == has a maximum number of lines to prevent
" hanging. Disable that, because I'm happy to wait when I
" want this.
let g:clojure_maxlines = 0

" Unfortunately the default mappings for vim-sexp are hard
" to press (lots of ctrl & alt), but tpope has us covered:
call my_plugin#add('tpope/vim-sexp-mappings-for-regular-people')

" g:campfire selects vim-campfire over vim-fireplace. Set by
" ~/.config/nvim/campfire.vim launcher (-u campfire.vim).
let s:campfire = get(g:, 'campfire', 0) ? v:true : v:false
let s:fireplace = s:campfire ? v:false : v:true

echom s:campfire . 'bool'

" FiREPLace is a plugin for integrating with a Clojure
" nREPL.
call my_plugin#add('SevereOverfl0w/vim-fireplace', #{branch: 'dominic/patches', enabled: s:fireplace})
" Disable auto-nashorn
let g:fireplace_cljs_repl = ''

" vim-campfire: alternative nREPL client used when g:campfire=1.
call my_plugin#add('SevereOverfl0w/vim-campfire', #{enabled: s:campfire})
" TODO: add none-ls here

let g:FIREPLACE_PRINT_META = get(g:, 'FIREPLACE_PRINT_META', v:true)

function! Pprint_fun(msg, width)
  let opts = #{}
  if g:FIREPLACE_PRINT_META
    let opts['print-meta'] = v:true
  endif
  call fireplace#pprint_puget(a:msg, a:width, opts)
endfunction

let g:Fireplace_pprint_func = 'Pprint_fun'

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

" Prevent fireplace from creating tag bindings, in favour of using LSP with a tagfunc
let g:nremap = get(g:, 'nremap', {})
call extend(g:nremap, {
      \ '<C-]>': '',
      \ 'g<LeftMouse>': '',
      \ '<C LeftMouse>': '',
      \ 'g]': '',
      \ 'g<C-]>': '',
      \ '<C-W>]': '',
      \ '<C-W><C-]>': '',
      \ '<C-W>g]': '',
      \ '<C-W>g<C-]>': '',
      \ })

if s:fireplace
  augroup FireplaceCustom
      autocmd!
      autocmd FileType clojure call s:SetupBind()
      autocmd User FireplaceActivate call s:SetupBind()
  augroup END
endif


" async-clj-omni is an auto-completion plugin for
" clojure
call my_plugin#add('clojure-vim/async-clj-omni')

" augroup ClojureLint
" autocmd!
" autocmd BufWritePost *.clj silent Make
" augroup END
" }}}
