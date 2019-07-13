function! s:get_function(name)
  try
    return function(a:name)
  catch /.*/
    return
  endtry
endf

function s:is_func(x)
  return type(a:x) == v:t_func
endf

function s:plugin_hook(prefix)
  let name = substitute(g:dein#plugin.normalized_name, '-', '_', 'g')
  let F = s:get_function('Hook_'.a:prefix.'_'.name)
  if !s:is_func(F)
    return
  endif

  call F()
endf

function my_plugin#add_hooks()
  call dein#set_hook([], 'hook_add', function('s:plugin_hook', ['add']))
  call dein#set_hook([], 'hook_post_source', function('s:plugin_hook', ['post_source']))
endf

function my_plugin#begin()
  set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
endf

function my_plugin#end()
  call dein#end()

  if dein#check_install()
    echom 'Need to run dein#install()'
    " call dein#install()
  endif

  augroup PostSource
    autocmd!
    autocmd VimEnter * call dein#call_hook('post_source')
  augroup END
  call my_plugin#add_hooks()

  filetype plugin indent on
  syntax enable
endf

function my_plugin#run()
  runtime! config/*.vim
  call my_plugin#begin()
  runtime! dein-plugin/*.vim
  call my_plugin#end()
endf
