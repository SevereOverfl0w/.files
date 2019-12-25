scriptencoding utf-8
" sneak provides alternatives to f,F which:
" - Work across lines
" - Provides an awesome label mode which prompts for a
"   character
" - Very fast (compared to alternatives I've tried)
call my_plugin#add('justinmk/vim-sneak')

function! Hook_add_sneak()
 " Enable labels for jumping around
 let g:sneak#label = 1

 " By default, vim-sneak uses z for operator-pending mode,
 " and s for normal mode.  Unfortunately s collides with
 " vim-sandwich (sandwich).  I really want consistency for
 " my choice of mappings though.  vim-sneak is really
 " important, I use it more often than vim-sandwich.
 omap s <Plug>Sneak_s
 omap S <Plug>Sneak_S
  
 " vim-sneak doesn't rebind f,F,t,T by default to it's
 " slightly improved versions by default.  NOTE: vim-sneak
 " doesn't use label mode for these by default, see
 " |sneak-functions| for how to change that.
 map f <Plug>Sneak_f
 map F <Plug>Sneak_F
 map t <Plug>Sneak_t
 map T <Plug>Sneak_T

 " sindresorhus found the best prompt character in unicode,
 " use it for vim-sneak's prompt
 let g:sneak#prompt = '❯'
endf
