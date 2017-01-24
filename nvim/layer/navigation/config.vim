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

nnoremap <leader>juf :Unite -start-insert file_rec/async<CR>
nnoremap <leader>juj :Unite -start-insert jump<CR>
nnoremap <leader>jub :Unite -quick-match buffer<CR>
nnoremap <leader>ju/ :Unite -start-insert grep:.<CR>
nnoremap <leader>juC :Unite -start-insert -input=`expand('<cword>')` grep:.<CR>
nnoremap <leader>jum :Unite -smartcase mapping<CR>
nnoremap <leader>jugs :Unite -start-insert -force-redraw file_rec/git:--modified:--others:--exclude-standard<CR>
" Unite-Interface
nnoremap <leader>juir :UniteResume<CR>
nnoremap <leader>juin :UniteNext<CR>

nnoremap <leader>jd/ :Denite grep<CR>
nnoremap <leader>jdf :Denite file_rec<CR>
nnoremap <leader>jdl :Denite line<CR>
nnoremap <leader>jdb :Denite buffer<CR>
nnoremap <leader>jdh :Denite help<CR>

map <leader>jjl <Plug>(easymotion-bd-jk)

" Ubiquitous mappings
nnoremap <leader>j/ :Denite grep<CR>
nnoremap <leader>jF :Denite file_rec<CR>
nnoremap <leader>jb :Unite -quick-match buffer<CR>
map <leader>jk <Plug>(signjk-jk)
map <leader>jw <Plug>(easymotion-bd-w)
map <leader>jf <Plug>(easymotion-bd-f)

