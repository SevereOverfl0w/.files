" let g:signjk#dummysign = 0
let ignore_dirs = ['talks', 'out', '.cljs_rhino_repl', 'target', '.idea']
let ignore_file_exts = ['pack.js', 'min.css', 'min.js']

if executable('rg')
  " Use rg for denite
  " https://github.com/BurntSushi/ripgrep
  call denite#custom#var('grep', 'command', ['rg'])

  let rg_ignores = map(copy(ignore_file_exts), '"!*.".v:val')
	\ + map(copy(ignore_dirs), '"!./".v:val."/**/*"')

  let rg_ignore_args = []
  for i in rg_ignores
    let rg_ignore_args = rg_ignore_args + ['-g', i]
  endfor

  call denite#custom#var('grep', 'default_opts',
			  \ ['--vimgrep', '--no-heading', '-i']
			  \ + rg_ignore_args)

  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])

  call denite#custom#var('file_rec', 'command', ['rg', '--files'] + rg_ignore_args)

  let g:fzf_rg_command = 'rg --column --line-number --no-heading --fixed-strings --hidden --follow --color "always"'
  for i in ignore_file_exts
    let g:fzf_rg_command .= ' -g ''!*.'.i."'"
  endfor
  for i in ignore_dirs
    let g:fzf_rg_command .= ' -g ''!./'.i.'/**/*'''
  endfor
endif

let g:fzf_files_options =
  \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'
let g:fzf_gfiles_options = g:fzf_files_options

let fugitive_diff = {
      \ 'description' : 'Run :Gvdiff against the file',
      \ }

function! fugitive_diff.func(candidate)
  execute 'Gvdiff ' . a:candidate.word
endfunction

call denite#custom#option('default', 'prompt', ' ❯')

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_skipfoldedline = 0

nnoremap <leader>d/ :Denite grep<CR>
nnoremap <leader>dF :Denite file_rec<CR>
nnoremap <leader>dl :Denite line<CR>
nnoremap <leader>db :Denite buffer<CR>
nnoremap <leader>dh :Denite help<CR>

map <leader>dl <Plug>(easymotion-bd-jk)

command! -bang -nargs=* Rg call fzf#vim#grep(g:fzf_rg_command.' '.shellescape(<q-args>).' | tr -d "\017"', 1, <bang>0)
" Ubiquitous mappings
"" Grepping
nnoremap <leader>j/ :execute ':Rg '.input('Pattern: ')<CR>
nnoremap <leader>jC :execute ':Rg '.expand('<cword>')<CR>
"" File
nnoremap <leader>jF :Files<CR>
nnoremap <leader>jG :GFiles?<CR>
"" Vim-things
nnoremap <leader>jb :Buffers<CR>
nnoremap <leader>jB :Lines<CR>
nnoremap <leader>jj :Denite jump<CR>
nnoremap <leader>jh :Helptags<CR>
nnoremap <leader>jl :BLines<CR>
"" Within view
map <leader>jk <Plug>(signjk-jk)
map <leader>jw <Plug>(easymotion-bd-w)
map <leader>jf <Plug>(easymotion-bd-f)
