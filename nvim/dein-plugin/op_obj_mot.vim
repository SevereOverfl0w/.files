" Operators allow you to perform actions (operations) on
" text objects and motions.  I collect additional generic
" ones to make my life easier.  A lot of them depend on
" vim-operator-user
" I'm trying to use the <Leader>o prefix (for operator).

" The replace operator allows you to replace an object with
" the value in the register (clipboard).
call dein#add('kana/vim-operator-replace')

function! Hook_add_operator_replace()
  map <Leader>or <Plug>(operator-replace)
endf

" These plugins enhance the kind of things you can refer to. e.g. sentences,
" words, lines, indentation level.  vim-sneak could fit into this category,
" but it shines on it's own.

" This is a dependency of many textobjs for defining themselves.
call dein#add('kana/vim-textobj-user')

" This adds a text object which refers to the whole buffer.  Pairs well with
" fireplace's `cp` motion, in place of doing `%:Eval`, and also with `=`.
"
" Defaults to binding `ae` and `ie`.  This is incompatible
" with vim-sexp though, so remap to aE and Ie.  I don't
" expected to use this mapping too much.
"
call dein#add('kana/vim-textobj-entire',
      \ {'depends': ['vim-textobj-user']})

function! Hook_add_textobj_entire()
  let g:textobj_entire_no_default_key_mappings = 1
  xmap aE <Plug>(textobj-entire-a)
  omap aE <Plug>(textobj-entire-a)
  xmap iE <Plug>(textobj-entire-i)
  omap iE <Plug>(textobj-entire-i)
endf

" Adds a text object which refers to the current line.
" Binds to `al` and `il` by default.
call dein#add('kana/vim-textobj-line')

" Wordmotion creates word definitions which surpass the
" default ones in utility.  The readme does a better job of
" explaining than I can.
call dein#add('chaoren/vim-wordmotion')
