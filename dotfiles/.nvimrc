" vim-Plug {{{
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
    UpdateRemotePlugins
  endif
endfunction

call plug#begin('~/.config/nvim/plugged')
" # Core / Misc
Plug 'neovim/node-host'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-eunuch'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'chriskempson/base16-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/vim-easy-align'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Shougo/deoplete.nvim'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'jreybert/vimagit'
Plug 'AlessandroYorba/Alduin'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'junegunn/limelight.vim'
Plug 'easymotion/vim-easymotion'

" # Nyaovim
Plug 'rhysd/nyaovim-popup-tooltip'
Plug 'rhysd/nyaovim-mini-browser'
Plug 'rhysd/nyaovim-markdown-preview'

" # Misc languages
Plug 'ledger/vim-ledger'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'marijnh/tern_for_vim', {'for': 'javascript', 'do': 'npm install'}
Plug 'mxw/vim-jsx', {'for': 'javascript'}
Plug 'kchmck/vim-coffee-script', {'for': 'coffee'}
Plug 'digitaltoad/vim-jade', {'for': 'jade'}
Plug 'groenewege/vim-less', {'for': 'less'}
Plug 'wavded/vim-stylus', {'for': 'stylus'}
Plug 'othree/html5.vim', {'for': ['html', 'jade', 'htmldjango']}
Plug 'mattn/emmet-vim/', {'for': ['html', 'htmldjango', 'jade']}
Plug 'reedes/vim-pencil'

" # Clojure
Plug 'tpope/vim-salve', {'for': 'clojure'}
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'guns/vim-clojure-static', {'for': 'clojure'} " More up to date
Plug 'guns/vim-clojure-highlight', {'for': 'clojure'}
Plug 'Deraen/vim-cider', {'for': 'clojure'}
Plug 'snoe/clj-refactor.nvim'
Plug '~/src/SevereOverfl0w/async-clj-omni'
Plug '~/src/SevereOverfl0w/deoplete-github'

Plug 'guns/vim-sexp'
" Plug 'vim-scripts/paredit.vim'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'kien/rainbow_parentheses.vim', {'for': 'clojure'}
" Plug 'venantius/vim-cljfmt', {'for': 'clojure'}
" Plug 'snoe/nvim-parinfer.js'


Plug '~/src/async-clj-omni'
call plug#end()
" }}}

" Config a few things
let g:airline_powerline_fonts=1
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:paredit_electric_return=0
let g:clj_fmt_autosave = 0

" Mappings {{{
let mapleader="\<Space>"
let maplocalleader=","

inoremap jk <Esc>
tnoremap jk <C-\><C-n>
" Edit/Source vim.
nnoremap <leader>ev :split $MYVIMRC<enter>
nnoremap <leader>sv :so $MYVIMRC<enter>
" Quicker jumping to start/end of lines.
nnoremap L $
nnoremap H ^
vnoremap L $
vnoremap H ^
" Toggle limelight
let g:limelight_conceal_ctermfg = 'gray'
nnoremap <leader>ll :Limelight!!<cr>

" inoremap <expr> <tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()

" Quick commit a file
nnoremap <leader>gw :Gwrite<enter>:Gcommit<enter>i


let g:unite_source_rec_async_command = ['ag', '--nocolor', '-g', '']
nnoremap <leader>gp :Unite file_rec/git:--cached:--others:--exclude-standard<cr>
" TODO: Switch to neovim when neovim/neovim#3757
nnoremap <leader>p :Unite file_rec/async<cr>
nnoremap <leader>s :Unite -quick-match buffer<cr>
nnoremap <leader>/ :Unite grep:.<cr>
nnoremap <leader>m :Unite mapping<cr>

nnoremap ]u :UniteNext<cr>
nnoremap [u :UnitePrevious<cr>

nnoremap ]t :tabnext<cr>
nnoremap [t :tabprev<cr>


nnoremap <leader>go :call fireplace#echo_session_eval('(go)', {'ns': 'dev'})<cr>
nnoremap <leader>rl :call fireplace#echo_session_eval('(reset)', {'ns': 'dev'})<cr>
nnoremap <leader>ra :call fireplace#echo_session_eval('(reset-all)', {'ns': 'dev'})<cr>
nnoremap <leader>rt :call fireplace#echo_session_eval('(restart)', {'ns': 'dev'})<cr>
nmap gs <Plug>FireplaceDjump

map <leader>j <Plug>(easymotion-bd-jk)
map <Leader>f <Plug>(easymotion-bd-f)

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" Colours {{{
syntax on
" set autoindent
set background=dark
" set t_Co=256
let base16colorspace=256
set ls=2 "Show vim-airline always
set number
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * hi BadGit ctermbg=red guibg=red
colorscheme alduin
let g:airline_theme='base16' 
" colorscheme base16-default
"
let g:rbpt_colorpairs = [
	\ ['brown',       'RoyalBlue3'],
	\ ['Darkblue',    'SeaGreen3'],
	\ ['darkgray',    'DarkOrchid3'],
	\ ['darkgreen',   'firebrick3'],
	\ ['darkcyan',    'RoyalBlue3'],
	\ ['darkred',     'SeaGreen3'],
	\ ['darkmagenta', 'DarkOrchid3'],
	\ ['brown',       'firebrick3'],
	\ ['gray',        'RoyalBlue3'],
	\ ['darkmagenta', 'DarkOrchid3'],
	\ ['Darkblue',    'firebrick3'],
	\ ['darkgreen',   'RoyalBlue3'],
	\ ['darkcyan',    'SeaGreen3'],
	\ ['darkred',     'DarkOrchid3'],
	\ ['red',         'firebrick3'],
	\ ]


" }}}

" General {{{
set tabstop=4 softtabstop=2 expandtab shiftwidth=2 smarttab
set backspace=indent,eol,start
set dir=~/.tmp,/var/tmp,/tmp  " No more swp files in project dirs
set smartcase
" }}}

" Language specific tweaks {{{
autocmd Filetype javascript set foldmethod=syntax
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.boot set filetype=clojure
autocmd BufNewFile,BufReadPost *.edn set filetype=clojure
autocmd BufNewFile,BufReadPost *.clj* set filetype=clojure
autocmd BufNewFile,BufReadPost [gG]ulpfile* set filetype=javascript.gulpfile
autocmd BufNewFile,BufReadPost *.clj* RainbowParenthesesToggle

"" Match bad first lines in Git Commits (Lowercase, and sentence)
au Filetype gitcommit mat BadGit /\(^\l\|\.$\)\&\%1l/
" }}}

" FastFold {{{
" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
" }}}

" Unite.vim {{{
" Ignores for Unite.vim
call unite#custom#source('file_rec,file_rec/async,file_rec/git', 'ignore_pattern', 'node_modules')
call unite#custom#profile('default', 'context', {
      \   'start_insert': 1,
      \   'prompt': '» '
      \ })

if executable('ag')
  " Use ag (the silver searcher)
  " https://github.com/ggreer/the_silver_searcher
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
  \ '-i --vimgrep --hidden --ignore ' .
  \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
endif
" }}}

match ExtraWhitespace /\s\+$/

" Deoplete {{{
let g:deoplete#disable_auto_complete = 0
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#input_patterns = {}
" call deoplete#util#set_pattern(
"   \ g:deoplete#omni#input_patterns,
"   \ 'sh', ['.'])

let g:deoplete#sources = {}
let g:deoplete#sources._=['buffer', 'ultisnips', 'file']
let g:deoplete#sources._=['dictionary']
let g:deoplete#sources.clojure=['async_clj', 'file']
let g:deoplete#sources.gitcommit=['file', 'ultisnips', 'github']
let g:deoplete#sources.asciidoc=['dictionary', 'file']

let g:deoplete#auto_completion_start_length = 1
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.]*'
let g:deoplete#keyword_patterns.gitcommit = '.+'

call deoplete#util#set_pattern(
  \ g:deoplete#omni#input_patterns,
  \ 'gitcommit', [g:deoplete#keyword_patterns.gitcommit])

call deoplete#util#set_pattern(
  \ g:deoplete#omni#input_patterns,
  \ 'lisp,clojure', [g:deoplete#keyword_patterns.clojure])

" }}}

" Ledger {{{

let g:ledger_detailed_first = 1
call deoplete#util#set_pattern(
  \ g:deoplete#omni#input_patterns,
  \ 'ledger', ['\w+'])

nnoremap <leader>ud :call ledger#transaction_date_set(line('.'), 'primary')<cr>
nnoremap <leader>it :call ledger#entry()<cr>
nnoremap <leader>ts :call ledger#transaction_state_toggle(line('.'), ' *?!')<cr>
" }}}

" Clojure {{{
call deoplete#util#set_pattern(
  \ g:deoplete#omni#input_patterns,
  \ 'lisp,clojure', ['[\w!$%&*+/:<=>?@\^_~\-].*'])

" let g:clojure_align_subforms = 1
let g:clojure_align_multiline_strings = 1
" Fancier highlighting:
autocmd BufRead *.clj try | ClojureHighlightReferences | catch /^Fireplace/ | endtry
" Parinfer {{{
let g:parinfer_airline_integration = 1
function! ParinferToggle()
  if g:parinfer_mode =~ "paren"
    let g:parinfer_mode = "indent"
  elseif g:parinfer_mode =~ "indent"
    let g:parinfer_mode = "paren"
  endif
endfunction

nnoremap <leader>( :call ParinferToggle()<CR>
" }}}
" }}}

au FileType muttrc setlocal foldmethod=marker
au FileType vim setlocal foldmethod=marker kp=:help
