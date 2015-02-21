call plug#begin('~/.nvim/plugged')
Plug 'marijnh/tern_for_vim', {'for': 'javascript'}
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'mxw/vim-jsx', {'for': 'javascript'}
Plug 'kchmck/vim-coffee-script', {'for': 'coffee'}
Plug 'digitaltoad/vim-jade', {'for': 'jade'}
Plug 'groenewege/vim-less', {'for': 'less'}
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'nanotech/jellybeans.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe'
Plug 'tomtom/tcomment_vim'
" Plug 'Raimondi/delimitMate'
call plug#end()

" Config a few things
let g:airline_powerline_fonts=1
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

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

syntax on
set autoindent
set background=dark
set t_Co=256
set ls=2 "Show vim-airline always
set number
colorscheme jellybeans
set tabstop=4 softtabstop=2 expandtab shiftwidth=2 smarttab
set backspace=indent,eol,start


" Language specific tweaks
au Filetype javascript set foldmethod=syntax
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
