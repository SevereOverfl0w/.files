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

  " Second parameter to dein#begin where plugins may be added from so it may
  " auto-recache.
  call dein#begin('~/.cache/dein', add(globpath(&rtp, 'dein-plugin/*.vim', 1, 1), $MYVIMRC))
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
endf

function my_plugin#end()
  call dein#end()

  if dein#check_install()
    echom 'Need to run dein#install()'
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

function my_plugin#add(name, ...)
  let dev_overrides = get(g:, 'dev_overrides', {})
  let name = a:name
  if has_key(dev_overrides, a:name)
    let dev_override = dev_overrides[a:name]
    if dev_override ==# '~/src'
      let name = '~/src/github.com/'.name
    else
      let name = dev_override
    endif
  endif
  call call('dein#add', [name] + a:000)
endf
