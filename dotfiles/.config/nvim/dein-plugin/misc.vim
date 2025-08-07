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

call my_plugin#add('zaid/vim-rec')

call my_plugin#add('tpope/vim-speeddating')

call my_plugin#add('tpope/vim-eunuch')

call my_plugin#add('rhysd/conflict-marker.vim')

let g:textobj_diff_no_default_key_mappings = 1
call my_plugin#add('kana/vim-textobj-diff', #{dependencies: ['kana/vim-textobj-user']})

" `:Git status` diffs include trailing whitespace for the diff.  So does `:Git show HEAD`
let g:extra_whitespace_ignored_filetypes = ['fugitive', 'git', 'gitcommit']
call my_plugin#add('bronson/vim-trailing-whitespace')

call my_plugin#add('tpope/vim-flagship')
let g:tabprefix = ''

function! Filename(bufnr) abort
  let buftype = getbufvar(a:bufnr, "&buftype")
  let f = getbufinfo(a:bufnr)[0].name
  if buftype ==# 'quickfix'
    return '[Quickfix List]'
  elseif buftype =~# '^\%(nofile\|acwrite\|terminal\)$'
    return empty(f) ? '[Scratch]' : f
  elseif empty(f)
    return '[No Name]'
  elseif buftype ==# 'help'
    return fnamemodify(f, ':t')
  endif
  let ns = substitute(matchstr(f, '^\a\a\+\ze:'), '^\a', '\u&', 'g')
  if len(ns) && exists('*' . ns . 'Real')
    try
      let f2 = {ns}Real(f)
      if !empty(f2)
        let f = f2
      endif
    catch
    endtry
  endif

  return f
endfunction

function! MaybeTabCwds(...)
    let args = copy(a:000)
    let tabnr = type(get(args, 0, '')) == type(0) ? remove(args, 0) : v:lnum
    let tabinfo = gettabinfo(tabnr)[0]

    let difftabs = []
    for windowid in tabinfo.windows
        if gettabwinvar(tabnr, windowid, 'fugitive_diff_restore')
            call add(difftabs, windowid)
        endif
    endfor

    if len(difftabs) == 2
        let f = FugitiveReal(getbufinfo(getwininfo(difftabs[0])[0].bufnr)[0].name)
        return pathshorten(fnamemodify(f, ':.'), 1)
    elseif len(tabinfo.windows) == 1
        return pathshorten(fnamemodify(Filename(getwininfo(tabinfo.windows[0])[0].bufnr), ':~:.'))
    else
        return flagship#tabcwds(tabnr, 'shorten',',')
    endif
endfunction
let g:tablabel = '%N%{flagship#tabmodified()} %{MaybeTabCwds()}'

call my_plugin#add('m00qek/baleia.nvim', {'rev': 'v1.4.0'})

function! MaybeActivateBaleia(baleia)
    if get(w:, 'quickfix_title', '') =~? 'clojure.test'
        setlocal modifiable undolevels=-1
        silent call a:baleia.once(bufnr('%'))
        setlocal nomodifiable nomodified
    endif
endfunction

function! Hook_post_source_baleia()
  let s:baleia = luaeval("require('baleia').setup({ strip_ansi_codes = false })")
  let s:baleia_strips = luaeval("require('baleia').setup()")
  command! BaleiaColorize call s:baleia.once(bufnr('%'))
  command! BaleiaLogs call s:baleia.logger.show()
  augroup BaleiaUser
    autocmd!
    autocmd BufReadPost quickfix call MaybeActivateBaleia(s:baleia_strips)
    autocmd BufWinEnter quickfix call MaybeActivateBaleia(s:baleia_strips)
  augroup END
endf

" call my_plugin#add('powerman/vim-plugin-ansiesc')

call my_plugin#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': ':TSUpdate'})

function! Hook_post_source_treesitter()
    lua <<EOF
    require'nvim-treesitter.configs'.setup {
        ensure_installed = { "lua", "vim", "vimdoc", "bash", "clojure" },
        highlight = {
            enable = true,
            disable = { "clojure", -- breaks vim-sexp
            },
        },
    }
EOF
endfunction

call my_plugin#add('RRethy/nvim-treesitter-endwise')

function! Hook_post_source_treesitter_endwise()
    lua require('nvim-treesitter.configs').setup { endwise = { enable = true, } }
endf

call my_plugin#add('AndrewRadev/inline_edit.vim')

call my_plugin#add('Apeiros-46B/qalc.nvim', #{opts: #{cmd_args: ["--set", "curconv 0"]}})

call my_plugin#add('terrastruct/d2-vim')

call my_plugin#add('mtikekar/nvim-send-to-term')
