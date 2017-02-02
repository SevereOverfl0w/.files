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

  " Use rg for unite
  " https://github.com/BurntSushi/ripgrep
  let g:unite_source_grep_command = 'rg'
  let g:unite_source_grep_default_opts = '-i --vimgrep'

  for i in ignore_file_exts
    let g:unite_source_grep_default_opts .= ' -g ''!*.'.i."'"
  endfor
  for i in ignore_dirs
    let g:unite_source_grep_default_opts .= ' -g ''!./'.i.'/**/*'''
  endfor

  let g:unite_source_grep_recursive_opt = ''

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

" Preferably, this would always be done via ignore to the commands themselves,
" but this isn't always possible (or I've not done it), this stands as a,
" slower, last barrier

fun! s:UniteDirToGlob(i)
  return './'.a:i.'/**'
endf

fun! s:UniteExtToGlob(i)
  return '*.'.a:i
endf

let unite_ignore_globs =
      \ Mapped(function("s:UniteDirToGlob"), ignore_dirs)
      \ + Mapped(function("s:UniteExtToGlob"), ignore_file_exts)

call unite#custom#source('file_rec/async,grep', 'ignore_globs', unite_ignore_globs)

" command! Glog :Unite gitlog:all:30

let fugitive_diff = {
      \ 'description' : 'Run :Gvdiff against the file',
      \ }

function! fugitive_diff.func(candidate)
  execute 'Gvdiff ' . a:candidate.word
endfunction

call denite#custom#option('default', 'prompt', ' ❯')
call unite#custom#profile('default', 'context', {
    \  'prompt': '❯ ',
    \  'winheight': 10,
    \   'direction': 'dynamicbottom',
\ })

highlight! link uniteInputPrompt GruvboxPurpleBold


let g:EasyMotion_do_mapping = 0
let g:EasyMotion_skipfoldedline = 0

nnoremap <leader>uF :Unite -start-insert file_rec/async<CR>
nnoremap <leader>uj :Unite -start-insert jump<CR>
nnoremap <leader>ub :Unite -quick-match buffer<CR>
nnoremap <leader>u/ :Unite -start-insert grep:.<CR>
nnoremap <leader>uC :Unite -start-insert -input=`expand('<cword>')` grep:.<CR>
nnoremap <leader>um :Unite -smartcase mapping<CR>
nnoremap <leader>ugs :Unite -start-insert -force-redraw file_rec/git:--modified:--others:--exclude-standard<CR>
" Unite-Interface
nnoremap <leader>uir :UniteResume<CR>
nnoremap <leader>uin :UniteNext<CR>

nnoremap <leader>d/ :Denite grep<CR>
nnoremap <leader>dF :Denite file_rec<CR>
nnoremap <leader>dl :Denite line<CR>
nnoremap <leader>db :Denite buffer<CR>
nnoremap <leader>dh :Denite help<CR>

map <leader>dl <Plug>(easymotion-bd-jk)

command! -bang -nargs=* Rg call fzf#vim#grep(g:fzf_rg_command.' '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
" Ubiquitous mappings
"" Grepping
nnoremap <leader>j/ :execute ':Rg '.input('Pattern: ')<CR>
nnoremap <leader>jC :execute ':Rg '.expand('<cword>')<CR>
"" File
nnoremap <leader>jF :Files<CR>
nnoremap <leader>jG :GFiles?<CR>
"" Vim-things
nnoremap <leader>jb :Buffers<CR>
nnoremap <leader>jj :Denite jump<CR>
nnoremap <leader>jh :Helptags<CR>
nnoremap <leader>jl :Lines<CR>
"" Within view
map <leader>jk <Plug>(signjk-jk)
map <leader>jw <Plug>(easymotion-bd-w)
map <leader>jf <Plug>(easymotion-bd-f)
