set colorcolumn=80
set clipboard+=unnamedplus,unnamed

set inccommand=split
" Let me run off and modify files without write
set hidden
" Make hidden less "evil"
set autowrite
" Macro redrawing
set lazyredraw
" Stop file watchers from freaking out
set directory=~/.local/share/nvim/tmp
set backupdir=~/.local/share/nvim/backup
" Better diffing
set diffexpr=py3diff#diffexpr()

" Insertion cursor is |
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

let g:localrc_filename = ".local.vim"

autocmd BufNewFile,BufRead init.vim
		  \ setlocal cc=60 |
		  \ setlocal foldmethod=marker |
		  \ setlocal autoindent

noremap <leader>vs :source $MYVIMRC<CR>
noremap <leader>ve :62vsplit $MYVIMRC<CR>

function! s:EditLayerComplete(ArgLead, CmdLine, CursorPos)
  return join(g:layer_names, "\n")
endfunction

function! s:LR(path)
  return resolve(expand(a:path))
endfunction

function! s:EditLayer(args)
  tabnew
  exec ':e '.s:LR(g:config_base_dir.'/layer/'.a:args.'/after')
  exec ':vsplit '.s:LR(g:config_base_dir.'/layer/'.a:args.'/config.vim')
  exec ':vsplit '.s:LR(g:config_base_dir.'/layer/'.a:args.'/package.vim')
endfunction

" Use custom, not customlist because vim filters the former
command! -complete=custom,s:EditLayerComplete -nargs=1 EditLayer :exe s:EditLayer(<q-args>)

nnoremap <silent> <Esc> :<C-U>call halo#run()<CR>
nnoremap <silent> <C-c> :<C-U>call halo#run()<CR><C-c>
