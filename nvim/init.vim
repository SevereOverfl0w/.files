" # Init.vim 2.0 {{{
" A few rules:
"   + Use structure:
"     By top-level (Mappings/Plugins/etc.)
"       |- Plugins
"          |- Git
"          |- Themes
"          |- etc.
"       |- Settings
"          |- Git
"          |- Themes
"          |- etc.
"       |- Autocmds
"          |- Git
"          |- init
"   + Limit to 60 chars, easier to edit in vsplit
"   + Commit Hard, Commit Often
"   + TextObj/Operator > Commands
"   + Use filetype files
"     - TODO: Document this here
"     - TODO: Mappings?
"}}}

" Plugins {{{
" Helper-fns {{{
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
" }}}
call plug#begin('~/.config/nvim/plugged')
  " Util {{{
  Plug 'Shougo/vimproc.vim', {'do': 'make'}
  Plug 'tpope/vim-dispatch'
  Plug 'radenling/vim-dispatch-neovim'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-eunuch'
  Plug 'neovim/node-host'
  " }}}
  " Interface {{{
  Plug 'Shougo/unite.vim'
  Plug 'junegunn/vim-peekaboo'
  Plug 'kshenoy/vim-signature' " Maybe nav?
  Plug 'mbbill/undotree'
  Plug 'Shougo/deoplete.nvim', {'do': function('DoRemote')}
  Plug 'vim-airline/vim-airline'
  " To do with over-running diffs. See beautiful diffs here:
  " https://github.com/blog/2188-git-2-9-has-been-released
  " for problem and what this plugin provides:
  Plug 'sgur/vim-py3diff'
  " }}}
  " Snippets {{{
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  " }}}
  " Theming {{{
  Plug 'morhetz/gruvbox'
  " }}}
  " Git {{{
  Plug 'tpope/vim-fugitive'
  Plug 'tommcdo/vim-fugitive-blame-ext'
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/gv.vim'
  " }}}
  " Navigating {{{
  Plug 'haya14busa/vim-signjk-motion'
  Plug 'easymotion/vim-easymotion'
  Plug 'junegunn/vim-pseudocl' | Plug 'junegunn/vim-oblique' " Improved /search
  " }}}
  " Text Objects {{{
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-line'
  Plug 'kana/vim-textobj-fold'
  Plug 'glts/vim-textobj-comment'
  Plug 'jasonlong/vim-textobj-css'
  Plug 'whatyouhide/vim-textobj-xmlattr'
  Plug 'chaoren/vim-wordmotion'
  " }}}
  " Operators {{{
  Plug 'tommcdo/vim-exchange'
  Plug 'tpope/vim-commentary'
  Plug 'machakann/vim-sandwich'

  Plug 'kana/vim-operator-user'
  Plug 'kana/vim-operator-replace'
  Plug 'deris/vim-operator-insert'
  " }}}
  " Lisp {{{
  Plug 'guns/vim-sexp' " Attempt to strip down?
  Plug 'luochen1990/rainbow'
  " }}}
  " Clojure {{{
  " :extends: lisp
  Plug 'tpope/vim-fireplace'
  " Plug 'tpope/vim-salve'
  Plug 'guns/vim-clojure-static'
  Plug 'guns/vim-clojure-highlight'
  Plug 'snoe/clj-refactor.nvim', {'do': function('DoRemote')}
  " Plug '~/src/SevereOverfl0w/async-clj-omni'
  Plug 'SevereOverfl0w/async-clj-omni'
  " }}}
  " Web (HTML, CSS, etc.) {{{
  Plug 'mattn/emmet-vim'
  " }}}
  " Misc {{{
  Plug 'chrisbra/csv.vim'
  Plug 'ledger/vim-ledger'
  Plug 'mrtazz/simplenote.vim'
  Plug 'thinca/vim-localrc'
  Plug 'floobits/floobits-neovim'
  " }}}
call plug#end()
" }}}
" Syntax {{{
highlight! link ExtraWhitespace Error
autocmd BufWinEnter *
      \ call matchadd('ExtraWhitespace', '\s\+$')
" }}}
" Settings {{{
  " Maplocals {{{
  let mapleader="\<Space>"
  let maplocalleader=","
  " }}}
  " Theming {{{
  set termguicolors
  set background=dark
  let g:gruvbox_italic = 1
  colorscheme gruvbox
  " Align signjk and gruvbox
  hi! link SignjkTarget GruvboxBlueSign
  hi! link SignjkTarget2 GruvboxYellowSign
  let g:airline_powerline_fonts = 1
  set colorcolumn=80
  " }}}
  " Git {{{
  let g:easygit_enable_command = 1
  let g:gitgutter_map_keys = 0
  " }}}
  " Clipboard {{{
  set clipboard=unnamedplus
  " }}}
  " Easymotion {{{
  let g:EasyMotion_do_mapping = 0
  " }}}
  " Unite {{{
  if executable('ag')
    " Use ag for unite
    " https://github.com/ggreer/the_silver_searcher
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
    \ '-i --vimgrep --hidden --ignore ' .
    \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
    call unite#custom#source('file_rec/async,grep', 'ignore_globs', ['./out/**', './.cljs_rhino_repl/**', './target/**'])
  endif
  " }}}
  " Deoplete {{{
  let g:deoplete#enable_at_startup = 1

  " Foo-bar

  let g:deoplete#sources = {}
  let g:deoplete#sources._=['buffer', 'ultisnips', 'file', 'dictionary']
  let g:deoplete#sources.clojure=['async_clj', 'file']

  " }}}
  " Easymotion {{{
  let g:EasyMotion_skipfoldedline = 0
  " }}}
  " SimpleNote {{{
  let g:SimplenoteUsername = "monroef4@googlemail.com"
  let g:SimplenoteFiletype = "asciidoc"
  " }}}
  " Textobj disabling {{{
  let g:textobj_css_no_default_key_mappings = 1
  " }}}
  " Vim settings {{{
  " I think I need this
  set hidden
  " Make hidden less "evil"
  set autowrite
  " Macro redrawing
  set lazyredraw
  " Better diff setup
  set diffexpr=py3diff#diffexpr()
  " Stop file watchers from freaking out
  set directory=~/.local/share/nvim/tmp
  " }}}
  " Rainbow Parens {{{
  let g:rainbow_active = 1
  " }}}
  " local-vimrc {{{
  let g:localrc_filename = ".local.vim"
  " }}}
  let g:clojure_special_indent_words = 'deftype,defrecord,reify,proxy,extend-type,extend-protocol,letfn,defcomponent'
  setlocal lispwords+=go-loop
" }}}
" Mappings {{{
  " Navigating {{{
  map <leader>jk <Plug>(signjk-jk)
  map <leader>jl <Plug>(easymotion-bd-jk)
  map <leader>jw <Plug>(easymotion-bd-w)
  map <leader>jf <Plug>(easymotion-bd-f)
  map <leader>eft :execute 'Ftplugin ' . &ft<CR>
  " --[Unite
  map <leader>uf :Unite -start-insert file_rec/async<CR>
  map <leader>uj :Unite -start-insert jump<CR>
  map <leader>ub :Unite -quick-match buffer<CR>
  map <leader>u/ :Unite -start-insert grep:.<CR>
  map <leader>uC :Unite -start-insert -input=`expand('<cword>')` grep:.<CR>
  map <leader>um :Unite -smartcase mapping<CR>
  map <leader>ugs :Unite -force-redraw file_rec/git:--modified:--others:--exclude-standard<CR>
  " Unite-Interface
  map <leader>uir :UniteResume<CR>
  map <leader>uin :UniteNext<CR>
  " }}}
  " Vimrc {{{
  noremap <leader>vs :source $MYVIMRC<CR>
  noremap <leader>ve :62vsplit $MYVIMRC<CR>
  " }}}
  " Operators {{{
  nmap !i  <Plug>(operator-insert-i)
  nmap !a  <Plug>(operator-insert-a)
  map !r <Plug>(operator-replace)
  " }}}
  " TextObj {{{
  xmap acr <Plug>(textobj-css-a)
  omap acr <Plug>(textobj-css-a)

  xmap icr <Plug>(textobj-css-i)
  omap icr <Plug>(textobj-css-i)
  " }}}
  " Git {{{
  nnoremap <Leader>gv :Gitv --all<CR>
  nnoremap <Leader>gV :Gitv! --all<CR>
  nnoremap <Leader>gs :Gstatus<CR>
  nnoremap <Leader>gc :Gcommit<CR>
  nnoremap <Leader>gp :Gpush<CR>
  nnoremap <Leader>gf :Gpull<CR>
  nnoremap <Leader>gW :Gwrite<CR>:Gcommit<CR>
  nnoremap <Leader>gd :Gdiff<CR>
  nnoremap <Leader>gD :Gvdiff<CR>
  nnoremap <Leader>gb :Gblame<CR>

  nmap [c <Plug>GitGutterPrevHunk
  nmap ]c <Plug>GitGutterNextHunk
  " }}}
  " Undotree {{{
  map <leader>uT :UndotreeShow<CR>
  " }}}
" }}}
" Commands {{{
  " Git {{{
  command! Glog :Unite gitlog:all:30
  " }}}
  " init.vim maintenance {{{
  command! -complete=filetype -nargs=1 Ftplugin :edit ~/.config/nvim/ftplugin/<args>.vim
  " }}}
  " Simplenote {{{
  command! SimpleNoteLogin :let g:SimplenotePassword=systemlist('pass "master/Productivity Tools/Sign in to Simplenote"')[0]
  " }}}
" }}}
" Autocmds {{{
  " Init.vim {{{
  autocmd BufNewFile,BufRead init.vim 
                          \ setlocal cc=60 |
                          \ setlocal foldmethod=marker |
                          \ setlocal autoindent
  " }}}
" }}}

let fugitive_diff = {
      \ 'description' : 'Run :Gvdiff against the file',
      \ }

function! fugitive_diff.func(candidate)
  execute 'Gvdiff ' . a:candidate.word
endfunction

call unite#custom#action('file', 'fugitivediff', fugitive_diff)
