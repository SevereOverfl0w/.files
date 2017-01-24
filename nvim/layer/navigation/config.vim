let ignore_dirs = ['talks', 'out', '.cljs_rhino_repl', 'target', '.idea']
let ignore_file_exts = ['pack.js', 'min.css', 'min.js']

" Denite
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
endif

call denite#custom#option('default', 'prompt', ' ❯')


if executable('rg')
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
elseif executable('ag')
  " Use ag for unite
  " https://github.com/ggreer/the_silver_searcher
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
  \ '-i --vimgrep --hidden --ignore ' .
  \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
endif

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

nnoremap <leader>uf :Unite -start-insert file_rec/async<CR>
nnoremap <leader>uj :Unite -start-insert jump<CR>
nnoremap <leader>ub :Unite -quick-match buffer<CR>
nnoremap <leader>u/ :Unite -start-insert grep:.<CR>
nnoremap <leader>uC :Unite -start-insert -input=`expand('<cword>')` grep:.<CR>
nnoremap <leader>um :Unite -smartcase mapping<CR>
nnoremap <leader>ugs :Unite -start-insert -force-redraw file_rec/git:--modified:--others:--exclude-standard<CR>
nnore" Unite-Interface
nnoremap <leader>uir :UniteResume<CR>
nnoremap <leader>uin :UniteNext<CR>

" command! Glog :Unite gitlog:all:30

let fugitive_diff = {
      \ 'description' : 'Run :Gvdiff against the file',
      \ }

function! fugitive_diff.func(candidate)
  execute 'Gvdiff ' . a:candidate.word
endfunction

call unite#custom#profile('default', 'context', {
    \  'prompt': '❯ ',
    \  'winheight': 10,
    \   'direction': 'dynamicbottom',
\ })

highlight! link uniteInputPrompt GruvboxPurpleBold

nnoremap <leader>d/ :Denite grep<CR>
nnoremap <leader>df :Denite file_rec<CR>
nnoremap <leader>dl :Denite line<CR>
nnoremap <leader>db :Denite buffer<CR>
nnoremap <leader>dh :Denite help<CR>
