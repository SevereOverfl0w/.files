" vim:fdm=marker:tw=58
" source ~/src/github.com/SevereOverfl0w/vim-zeno/zeno.vim

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Dein hook utils {{{
let g:hook_add = {}
let g:hook_source = {}
let s:add_calls = []

function! Normalize(repo)
  let name = dein#parse#_name_conversion(a:repo)
  return substitute(substitute(fnamemodify(name, ':r'), '\c^n\?vim[_-]\|[_-]n\?vim$', '', 'g'), '-', '_', 'g')
endf

function! s:is_function(m, k)
  return type(get(a:m, a:k, 0)) == v:t_func
endf

" TODO: Use g:dein#plugin.name
function! s:add_hook(repo)
  let name = Normalize(a:repo)
  " let Hook = function(get(g:hook_add, name, 0), [], g:hook_add)

  if s:is_function(g:hook_add, name)
    call function(get(g:hook_add, name, 0), [], g:hook_add)()
  endif

  " if type(Hook) == v:t_func
  "   call Hook()
  " endif
endf

function! s:post_source_hook(repo)
  let name = Normalize(a:repo)
  " let Hook = function(get(g:hook_source, name, 0), [], g:hook_source)

  " echom v:vim_did_enter
  " if type(Hook) == v:t_func
  "   call Hook()
  " endif
  if s:is_function(g:hook_source, name)
    call function(get(g:hook_source, name, 0), [], g:hook_source)()
  endif
endf


function! s:add(...)
  let repo = a:1
  let opts = get(a:, 2, {})
  let opts.hook_add = function('s:add_hook', [repo])
  let opts.hook_post_source = function('s:post_source_hook', [repo])

  call add(s:add_calls, [repo, opts])
  " call dein#add(repo, opts)
endf

function! s:really_add()
  for x in s:add_calls
    call call('dein#add', x)
  endfor
endf
" }}}

" Dein intro {{{
call dein#begin('~/.cache/dein')

call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
" }}}

" Leader keys are important, because you bang on them all
" day They go first so that mappings after this point
" respect them
let mapleader=" "
let maplocalleader=","

" Enable true colour (16 million instead of 256) support
set termguicolors

" Set the clipboard to be the same as the system's
" clipboard, not vim's internal one:
set clipboard+=unnamedplus

" Reduce updatetime, the most visible effect is making
" gitgutter more responsive.  But also controls swap file
" write frequency.
set updatetime=100

" Configure replacements (e.g. :s) to show a preview of
" what's changing
set inccommand=split

call s:add('sonph/onehalf', {'rtp': 'vim/'})

function g:hook_source.onehalf()
  colorscheme onehalflight
endf

call s:add('ap/vim-css-color')

" vim-sneak {{{
" sneak provides alternatives to f,F which:
" - Work across lines
" - Provides an awesome label mode which prompts for a
"   character
" - Very fast (compared to alternatives I've tried)
call s:add('justinmk/vim-sneak')

function! g:hook_add.sneak()
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

" }}}

" A few plugins require this plugin in order to make their
" own operators.  More than just those in operators.
call s:add('kana/vim-operator-user')

" This is both a utility and dependency of a few plugins
" (fugitive, rhubarb, jack-in)
call s:add('tpope/vim-dispatch')

" This provides dispatch with a neovim :terminal based
" interface. This means that `:Start` will open a terminal
" in a tab.
" call s:add('radenling/vim-dispatch-neovim')

" This plugin extends the functionality of `.`.  I added it
" initially for support with >) from vim-sexp, but
" vim-sneak and many others also use it.
call s:add('tpope/vim-repeat')

" Some plugins require this in order to figure out the
" contextual filetype (e.g. in a [source] block in
" asciidoc, or in ```clojure in markdown) Plug
" Used by:
" - deoplete
call s:add('Shougo/context_filetype.vim')

" Commenting {{{
" tcomment is pretty solid, works well with motions and
" "gcc" does what I mean. Unfortunately it doesn't support
" context filetypes very well, so I'm looking at how I can
" change that, caw.vim does, but doesn't work well with
" motions.

call s:add('tomtom/tcomment_vim')

function! g:hook_add.tcomment()
  " I really don't like the insert-mode mappings it creates:
  let g:tcomment_mapleader1 = ''
  let g:tcomment_mapleader2 = ''
endf

function! g:hook_source.tcomment()
  " Integrate tcomment with terraform
  call tcomment#type#Define('terraform', '# %s')
  call tcomment#type#Define('terraform_block', '/* %s */' )
  call tcomment#type#Define('terraform_inline', '/* %s */' )
endf
" }}}

" Surround things {{{

" TODO: Position
" vim-sandwich looks at vim-surround and says "ha, that is
" no true operator", and fixes that.
call s:add('machakann/vim-sandwich')

function! g:hook_add.sandwich()
  " The default key mappings collide with s from vim-sneak,
  " so bind them behind leader.  I don't use them too often,
  " so I don't think it's a massive loss having them be 3
  " keypresses away instead of 2.
  let g:sandwich_no_default_key_mappings = 1
  let g:operator_sandwich_no_default_key_mappings = 1

  silent! nmap <unique><silent> <leader>sd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
  silent! nmap <unique><silent> <leader>sr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
  silent! nmap <unique><silent> <leader>sdb <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
  silent! nmap <unique><silent> <leader>srb <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)

  " add
  silent! nmap <unique> <leader>sa <Plug>(operator-sandwich-add)
  silent! xmap <unique> <leader>sa <Plug>(operator-sandwich-add)
  silent! omap <unique> <leader>sa <Plug>(operator-sandwich-g@)
  silent! xmap <unique> <leader>sd <Plug>(operator-sandwich-delete)
  silent! xmap <unique> <leader>sr <Plug>(operator-sandwich-replace)
endf

function! g:hook_source.sandwich()
  " Sandwich has this cute highlighting trick where it shows
  " the thing it's deleting/surrounding in a special
  " highlight. The only duration that enables you to see this
  " is 200ms. For deletes this makes them feel slow, and you
  " can barely see it, so disable highlighting for delete.
  call operator#sandwich#set('delete', 'all', 'highlight', 0)

  " Recipe list:
  " - In vim files, `pg` will surround the snippet as `Plug '%s'` for
  "   integration with vim-plug
  " - In adoc files kbd:[] macro available
  let s:local_recipes = [
        \ {'__filetype__': 'vim', 'buns': ["s:add('", "')"], 'input': [ 'pg' ], 'filetype': ['vim']},
        \ {'__filetype__': 'vim', 'buns': ["zeno#github('", "')"], 'input': [ 'zn' ], 'filetype': ['vim']},
        \ {'__filetype__': 'asciidoc', 'buns': ["kbd:[", "]"], 'input': [ 'kbd' ], 'filetype': ['asciidoc']}]
  " Adding custom recipes involves copying the default
  " recipes and adding.
  let g:sandwich#recipes = deepcopy(sandwich#get_recipes())
  let g:sandwich#recipes += s:local_recipes
endf

" }}}

" Clojure {{{

" Update the static files for clojure from it's upstream,
" this includes fixes like indenting #() properly.
call s:add('guns/vim-clojure-static')

" This plugin allows you to manipulate sexp (clojure
" parens) in magical ways.
call s:add('guns/vim-sexp')

" By default == has a maximum number of lines to prevent
" hanging. Disable that, because I'm happy to wait when I
" want this.
let g:clojure_maxlines = 0

" Unfortunately the default mappings for vim-sexp are hard
" to press (lots of ctrl & alt), but tpope has us covered:
call s:add('tpope/vim-sexp-mappings-for-regular-people')

" FiREPLace is a plugin for integrating with a Clojure
" nREPL.
call s:add('tpope/vim-fireplace')

" REPLant is a plugin for enhancing your REPL experience
" with vim I develop this, so I've selected my src dir.
" Plug '~/src/github.com/SevereOverfl0w/replant'
call s:add('~/src/github.com/SevereOverfl0w/replant')

" A plugin for managing nREPL middleware and starting the
" nREPL.
call s:add('~/src/github.com/clojure-vim/vim-jack-in')

function! g:hook_source.jack_in()
let g:jack_in_injections['cider/piggieback'] =
    \  {'version': '0.4.1',
    \   'middleware': 'cider.piggieback/wrap-cljs-repl'}
endf

" async-clj-omni is an auto-completion plugin for
" deoplete.
call s:add('clojure-vim/async-clj-omni',
      \ {'depends': ['deoplete.nvim']})
" }}}

" Terraform {{{

" vim-terraform "fixes" syntax detection for *.tf to be
" terraform files
call s:add('hashivim/vim-terraform')

" Provides:
" - Contextual completions with deoplete support
" - Automatic linting via syntastic or neomake
" - Tagbar integration
" - Keybindings for docs
" For now I am mostly using the completion though.
call s:add('juliosueiras/vim-terraform-completion')

function! g:hook_add.terraform_completion()
  " Disable slow registry search for auto-completion
  let g:terraform_module_registry_search = 0
endf

" }}}

" Operators {{{

" Operators allow you to perform actions (operations) on
" text objects and motions.  I collect additional generic
" ones to make my life easier.  A lot of them depend on
" vim-operator-user
" I'm trying to use the <Leader>o prefix (for operator).

" The replace operator allows you to replace an object with
" the value in the register (clipboard).
call s:add('kana/vim-operator-replace')

function! g:hook_add.operator_replace()
  map <Leader>or <Plug>(operator-replace)
endf
" }}}

" Text Objects / Motions {{{

" These plugins enhance the kind of things you can refer to. e.g. sentences,
" words, lines, indentation level.  vim-sneak could fit into this category,
" but it shines on it's own.

" This is a dependency of many textobjs for defining themselves.
call s:add('kana/vim-textobj-user')

" This adds a text object which refers to the whole buffer.  Pairs well with
" fireplace's `cp` motion, in place of doing `%:Eval`, and also with `=`.
"
" Defaults to binding `ae` and `ie`.  This is incompatible
" with vim-sexp though, so remap to aE and Ie.  I don't
" expected to use this mapping too much.
"
call s:add('kana/vim-textobj-entire',
      \ {'depends': ['vim-textobj-user']})

function g:hook_add.textobj_entire()
  let g:textobj_entire_no_default_key_mappings = 1
  xmap aE <Plug>(textobj-entire-a)
  omap aE <Plug>(textobj-entire-a)
  xmap iE <Plug>(textobj-entire-i)
  omap iE <Plug>(textobj-entire-i)
endf

" Adds a text object which refers to the current line.
" Binds to `al` and `il` by default.
call s:add('kana/vim-textobj-line')

" Wordmotion creates word definitions which surpass the
" default ones in utility.  The readme does a better job of
" explaining than I can.
call s:add('chaoren/vim-wordmotion')
" }}}

" Git {{{
" Gitgutter {{{
" Gitgutter provides a few functions:
" - Show where files have changed via gutter icons
" - Text object for hunks
" - Staging / unstaging hunks
call s:add('airblade/vim-gitgutter')

function g:hook_add.gitgutter()
  " Disable gitgutter mappings, I can take care of that, thank you!
  let g:gitgutter_map_keys = 0
  " Apparently I can integrate with ripgrep really easily, and ripgrep is
  " awesome.
  if executable('rg')
    let g:gitgutter_grep = 'grep'
  endif

  " Configure gitgutter to ignore whitespace when
  " considering to show columns.
  let g:gitgutter_diff_args = '-w'

  " Mapping for jumping between hunks
  nmap ]h <Plug>GitGutterNextHunk
  nmap [h <Plug>GitGutterPrevHunk

  " Stage the hunk under the cursor
  nmap <Leader>ghs <Plug>GitGutterStageHunk
  " Show the diff of the hunk at cursor.  I'm not convinced this is actually
  " useful yet, but time will tell.
  nmap <Leader>ghp <Plug>GitGutterPreviewHunk
  " Discard the hunk under the cursor.  Useful for getting rid of println code.
  nmap <Leader>ghu <Plug>GitGutterUndoHunk
  " This is a text object referring to the current hunk
  omap ih <Plug>GitGutterTextObjectInnerPending
  omap ah <Plug>GitGutterTextObjectOuterPending
  xmap ih <Plug>GitGutterTextObjectInnerVisual
  xmap ah <Plug>GitGutterTextObjectOuterVisual
endf
" }}}

" Fugitive {{{
" FuGITive is a git wrapper for vim.  The interactive staging features are
" amazing.
call s:add('tpope/vim-fugitive')
" The official integration between fugitive and github
call s:add('tpope/vim-rhubarb')

" This list is butched from:
" https://www.reddit.com/r/vim/comments/21f4gm/best_workflow_when_using_fugitive/cgciltz/

" Stage file
nnoremap <Leader>ga :Git add %:p<CR><CR>
" Open status buffer
nnoremap <Leader>gs :Gstatus<CR>
" Commit normally
nnoremap <Leader>gc :Gcommit -v -q<CR>
" Commit and stage current file (if you commit only)
nnoremap <Leader>gt :Gcommit -v -q %:p<CR>
" Open current file in diff mode
nnoremap <Leader>gd :Gdiff<CR>
" Open current file on the index
nnoremap <Leader>ge :Gedit<CR>
" Like `:edit` but against the index
nnoremap <Leader>gr :Gread<CR>
" Like `:write` but against the index (stage file,
" basically)
nnoremap <Leader>gw :Gwrite<CR><CR>
" Open log for current file
nnoremap <Leader>gl :silent! Glog<CR>:bot copen<CR>
" git-grep version of :grep
nnoremap <Leader>gp :Ggrep<Space>
" Rename current buffer and do `git mv`
nnoremap <Leader>gm :Gmove<Space>
" Pass through to git
nnoremap <Leader>gb :Git branch<Space>
nnoremap <Leader>go :Git checkout<Space>
" Pull & push
nnoremap <Leader>gps :Dispatch! git push<CR>
nnoremap <Leader>gpl :Dispatch! git pull<CR>

nnoremap <Leader>gB :.Gbrowse<CR>
" }}}

" GV {{{
call s:add('junegunn/gv.vim')

nnoremap <Leader>gv :GV<CR>
nnoremap <Leader>gLL :GV!<CR>
" }}}
" }}}

" Completion {{{
" Deoplete provides asyncronous as-you-type completions
call s:add('Shougo/deoplete.nvim')

" It isn't enabled by default, so start it up
let g:deoplete#enable_at_startup = 1

" I set some deoplete patterns later on for filetypes
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.#]*'
let g:deoplete#omni_patterns = {}
')
" Terraform {{{
" TODO: This doesn't seem to cover all possible cases where
" terraform can do completions.
function! g:hook_source.deoplete()
  call deoplete#custom#var('omni', 'input_patterns', {
      \ 'terraform': '[^ *\t"{=$]\w*',
      \})
endf

" }}}
" }}}

" Grepping {{{

" vim-grepper helps you win at grep, integrated with the
" quickfix
call s:add('mhinz/vim-grepper')

let g:grepper = {}
" Change the preferred ordering of tools, ripgrep is too
" fast to say no
let g:grepper.tools = ['rg', 'ag', 'git', 'grep']

" I took the default value for this and added
" - `-L` to follow symlinks.
" - `--hidden` to search .files
" - `-S` smart casing
" - --max-columns=150 to prevent extremely long lines
"   crashing vim
let g:grepper.rg = get(g:grepper, 'rg', {})
let g:grepper.rg.grepprg = "rg -H -L --hidden -S -g '!.git' -g '!.stversions' --max-columns=150 --no-heading --vimgrep"
let g:grepper.simple_prompt = 1

" An operator for grepping. Allows me to do `<leader>GiW` or
" `<leader>Gie`, etc. to grep for a text object.
nmap <leader>G <plug>(GrepperOperator)
xmap <leader>G <plug>(GrepperOperator)
noremap <leader>/ :<C-u>Grepper<CR>

" A quick command for grepping my wiki
noremap <leader>w/ :<C-u>Grepper -dir ~/doc/<CR>
" }}}

" Quickfix {{{

" The quickfix is so important, especially with vim-grepper.
" vim-qf is romainl's collection of hacks for the quickfix.
call s:add('romainl/vim-qf')

" Wrapping version of :cnext and :cprev, for qf and location
" list.
nmap ]q <Plug>(qf_qf_next)
nmap [q <Plug>(qf_qf_previous)

nmap ]l <Plug>(qf_loc_next)
nmap [l <Plug>(qf_loc_previous)

" Add some reasonable convenience mappings:
" - s horizontal split, v vertical split
" - p open in preview
" - o open entry and return
let g:qf_mapping_ack_style = 1
" }}}

" Formatting {{{
" TODO: do not use tabs by default. 2/4 spaces maybe.
call s:add('tpope/vim-sleuth')
" }}}

" File jumping {{{

" This loads fzf from my filesystem.  I could perhaps
" have some check for existence, and fall back otherwise,
" but I don't want to.
" call s:add('junegunn/fzf')
call s:add('/usr/share/vim/vimfiles')

" `rg` respects gitignore anyway, so use a version of the
" default command without the direct git integration.
let $FZF_DEFAULT_COMMAND = "rg --files --hidden --follow -g '!.git' || ag -l -g \"\" || find ."

" The default colors look wrong
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Visual'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Visual'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Question'],
  \ 'pointer': ['fg', 'MatchParen'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header': ['fg', 'Comment'] }
" jf = jump file
nnoremap <Leader>jf :<C-U>FZF<CR>
nnoremap <leader>wf :<C-U>FZF ~/doc<CR>
" }}}

" vimrc {{{

" Since reading learn vimscript the hard way, I always keep
" these mappings available in some form.  The size was
" wrong when doing `:topleft :vsplit $MYVIMRC`, hence the
" function to make sure it's done hard & right.
function! Evimrc()
  topleft vsplit $MYVIMRC
  vertical resize 61
  setlocal winfixwidth
endf

noremap <Leader>ve :call Evimrc()<CR>
noremap <Leader>jv :call Evimrc()<CR>
" Unfortunately I can't think of a way to make this fit
" into other cute mnemonics.
noremap <Leader>vs :source $MYVIMRC<CR>
" }}}

" Expand %% to the cwd of the file to help with relative
" editing, e.g. `:e %%/` will work.
cabbr <expr> %% expand('%:p:h')

" Buffer switching {{{

" In the past I've used fzf.vim for switching buffers using
" a fuzzy matcher.  The best time was with unite's
" quick-switch mode.  Bufstop provides a feature like that.
" The "fallback" is to press a number followed by <CR>, not
" quite as fast, but still good.
call s:add('mihaifm/bufstop')

map <leader>b :BufstopFast<CR>
map <leader>B :ls<CR>:b
" }}}

" Line navigation {{{ 

" Navigating between lines for operations with jk for
" example
set number relativenumber
" }}}

" Persistent Undo {{{
let myUndoDir = fnamemodify(len($XDG_DATA_HOME) == 0 ? '~/.local/share' : $XDG_DATA_HOME, ':p:h') . '/nvim/myundodir'
call mkdir(myUndoDir, "p")
let &undodir = myUndoDir
set undofile
" }}}

" Wiki 2.0 {{{
call s:add('https://gitlab.com/dbeniamine/todo.txt-vim.git')

" Quickly jump to the root of the wiki in a tab
nnoremap <leader>wW :<C-U>tabnew \| tcd ~/doc/<CR>

nnoremap <leader>tG : ~/doc/todo.txt<Home>vimgrep<space>
nnoremap <leader>tj :<C-U>10split ~/doc/todo.txt<CR>

" Improve markdown support
call s:add('plasticboy/vim-markdown')
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_autowrite = 1
let g:vim_markdown_folding_style_pythonic = 1

map <leader>to  <Plug>(operator-add-todo)
map <leader>tO  <Plug>(operator-prompt-todo)

nnoremap <leader>tA :<C-U>AddTodo<space>

command! -nargs=* AddTodo call s:AppendToFile(expand('~/doc/todo.txt'), [join([<q-args>], ' ')])

call operator#user#define('add-todo', 'Add_todo')
call operator#user#define('prompt-todo', 'Prompt_todo')

function! Add_todo(motion_wise)
  let v = operator#user#visual_command_from_wise_name(a:motion_wise)

  let [original_U_content, original_U_type] = [@", getregtype('"')]
    execute 'normal!' '`['.v.'`]y'
    let keyword = @"
  call setreg('"', original_U_content, original_U_type)

  call s:AppendToFile(expand('~/doc/todo.txt'), [keyword . ''])
endfunction

function! Prompt_todo(motion_wise)
  let v = operator#user#visual_command_from_wise_name(a:motion_wise)

  let [original_U_content, original_U_type] = [@", getregtype('"')]
    execute 'normal!' '`['.v.'`]y'
    let keyword = @"
  call setreg('"', original_U_content, original_U_type)

  call feedkeys(":\<C-U>AddTodo " . keyword)
endfunction

function! s:AppendToFile(file, lines)
    call writefile(readfile(a:file)+a:lines, a:file)
endfunction

" Stolen from https://stackoverflow.com/a/4294176
" Affects more than the wiki.  TBD where this will live.
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" }}}

" Dein outro {{{
call s:really_add()

call dein#end()

if dein#check_install()
  echom 'Need to run dein#install()'
  " call dein#install()
endif

autocmd VimEnter * call dein#call_hook('post_source')

filetype plugin indent on
syntax enable
" }}}

" {{{ nvr integration
" Inside of neovim terminals, set the editor to nvr so I
" don't open a nested neovim.
if executable('nvr')
  let $VISUAL = 'nvr -cc split --remote-wait'
endif
" }}}
