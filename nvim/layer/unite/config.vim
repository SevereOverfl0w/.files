let ignore_dirs = ['talks', 'out', '.cljs_rhino_repl', 'target', '.idea']
let ignore_file_exts = ['pack.js', 'min.css', 'min.js']

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

map <leader>uf :Unite -start-insert file_rec/async<CR>
map <leader>uj :Unite -start-insert jump<CR>
map <leader>ub :Unite -quick-match buffer<CR>
map <leader>u/ :Unite -start-insert grep:.<CR>
map <leader>uC :Unite -start-insert -input=`expand('<cword>')` grep:.<CR>
map <leader>um :Unite -smartcase mapping<CR>
map <leader>ugs :Unite -start-insert -force-redraw file_rec/git:--modified:--others:--exclude-standard<CR>
" Unite-Interface
map <leader>uir :UniteResume<CR>
map <leader>uin :UniteNext<CR>

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
