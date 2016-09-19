set colorcolumn=80
set clipboard+=unnamedplus,unnamed

" Let me run off and modify files without write
set hidden
" Make hidden less "evil"
set autowrite
" Macro redrawing
set lazyredraw
" Stop file watchers from freaking out
set directory=~/.local/share/nvim/tmp
" Better diffing
set diffexpr=py3diff#diffexpr()

let g:localrc_filename = ".local.vim"

autocmd BufNewFile,BufRead init.vim 
		  \ setlocal cc=60 |
		  \ setlocal foldmethod=marker |
		  \ setlocal autoindent


highlight! link ExtraWhitespace Error
autocmd BufWinEnter *
      \ call matchadd('ExtraWhitespace', '\s\+$')

noremap <leader>vs :source $MYVIMRC<CR>
noremap <leader>ve :62vsplit $MYVIMRC<CR>

function! s:EditLayerComplete(ArgLead, CmdLine, CursorPos)
  return join(g:layer_names, "\n")
endfunction

function! s:EditLayer(args)
  exec ':10split '.g:config_base_dir.'/layer/'.a:args.'/config.vim'
  exec ':vsplit '.g:config_base_dir.'/layer/'.a:args.'/package.vim'
endfunction

" Use custom, not customlist because vim filters the former
command! -complete=custom,s:EditLayerComplete -nargs=1 EditLayer :exe s:EditLayer(<q-args>)
