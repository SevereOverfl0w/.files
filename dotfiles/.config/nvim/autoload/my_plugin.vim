function! s:get_function(name) abort
  if has_key(g:, a:name)
    return get(g:, a:name)
  endif
  try
    return function(a:name)
  catch /.*/
    return
  endtry
endf

function! s:is_func(x) abort
  return type(a:x) == v:t_func
endf

function! my_plugin#_is_find_function(name) abort
  return s:is_func(s:get_function(a:name))
endf

function! my_plugin#begin() abort
endf

let s:plugins = []

function! my_plugin#end() abort
  let g:plugins = s:plugins
  call luaeval("require('lazy').setup({spec = require('myplugin').makeargs(_A)})", s:plugins)

  filetype plugin indent on
  syntax enable
endf

function! my_plugin#run() abort
  runtime! config/*
  call my_plugin#begin()
  let s:plugins = []
  runtime! dein-plugin/*
  call my_plugin#end()
endf

function! my_plugin#add(name, ...) abort
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
  call add(s:plugins, [name] + a:000)
endf
