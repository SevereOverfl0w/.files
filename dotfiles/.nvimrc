call plug#begin('~/.config/nvim/plugged')
Plug 'neovim/node-host', {'commit': 'c02821ddaa555c24088b2b06ddc05ecf6b0c65b2'}
Plug 'marijnh/tern_for_vim', {'for': 'javascript', 'do': 'npm install'}
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'mxw/vim-jsx', {'for': 'javascript'}
Plug 'kchmck/vim-coffee-script', {'for': 'coffee'}
Plug 'digitaltoad/vim-jade', {'for': 'jade'}
Plug 'groenewege/vim-less', {'for': 'less'}
Plug 'wavded/vim-stylus', {'for': 'stylus'}
Plug 'othree/html5.vim', {'for': ['html', 'jade', 'htmldjango']}
Plug 'mattn/emmet-vim/', {'for': ['html', 'htmldjango', 'jade']}
Plug 'tpope/vim-salve', {'for': 'clojure'}
Plug 'tpope/vim-projectionist', {'for': 'clojure'}
Plug 'tpope/vim-dispatch', {'for': 'clojure'}
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'tpope/vim-eunuch'
Plug 'ledger/vim-ledger'
Plug 'radenling/vim-dispatch-neovim', {'for': 'clojure'}
Plug 'venantius/vim-cljfmt', {'on': 'Cljfmt'}
Plug 'kien/rainbow_parentheses.vim', {'for': 'clojure'}
Plug 'snoe/nvim-parinfer.js'
Plug 'nathanaelkane/vim-indent-guides', {'for': ['stylus', 'jade', 'python']}
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'jnurmine/Zenburn'
Plug 'chriskempson/base16-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/vim-easy-align'
Plug 'Shougo/unite.vim'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
call plug#end()

" Config a few things
let g:airline_powerline_fonts=1
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:paredit_electric_return=0

" Mappings
inoremap jk <Esc>
" Edit/Source vim.
nnoremap <leader>ev :split $MYVIMRC<enter>
nnoremap <leader>sv :so $MYVIMRC<enter>
" Quicker jumping to start/end of lines.
nnoremap L $
vnoremap L $
nnoremap H ^
vnoremap H ^

" fugitive bindings
nnoremap <leader>gw :Gwrite<enter>:Gcommit<enter>Go

syntax on
set autoindent
set background=dark
" set t_Co=256
let base16colorspace=256
set ls=2 "Show vim-airline always
set number
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
colorscheme base16-default
set tabstop=4 softtabstop=2 expandtab shiftwidth=2 smarttab
set backspace=indent,eol,start
set dir=~/.tmp,/var/tmp,/tmp  " No more swp files in project dirs


" Language specific tweaks
autocmd Filetype javascript set foldmethod=syntax
autocmd Filetype clojure set indentexpr=
autocmd Filetype clojure set autoindent
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.edn set filetype=clojure
autocmd BufNewFile,BufReadPost *.clj* set filetype=clojure
autocmd BufNewFile,BufReadPost [gG]ulpfile* set filetype=javascript.gulpfile
autocmd BufNewFile,BufReadPost *.clj* RainbowParenthesesToggle

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" Ignores for Unite.vim
call unite#custom#source('file_rec,file_rec/async,grep', 'ignore_pattern', 'node_modules')
call unite#custom#profile('default', 'context', {
      \   'start_insert': 1,
      \   'prompt': '» '
      \ })
nnoremap <C-p> :Unite file_rec/git<cr>
nnoremap <space>s :Unite -quick-match buffer<cr>
nnoremap <space>/ :Unite grep:.<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
nnoremap <leader>na :e assets/css/_

nnoremap <leader>go :call fireplace#echo_session_eval('(go)', {'ns': 'user'})<cr>
nnoremap <leader>rl :call fireplace#echo_session_eval('(reset)', {'ns': 'user'})<cr>
nnoremap <leader>ra :call fireplace#echo_session_eval('(reset-all)', {'ns': 'user'})<cr>

let g:sexp_enable_insert_mode_mappings = 0

match ExtraWhitespace /\s\+$/
