if executable('ag')
  " Use ag for unite
  " https://github.com/ggreer/the_silver_searcher
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
  \ '-i --vimgrep --hidden --ignore ' .
  \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
  call unite#custom#source('file_rec/async,grep', 'ignore_globs', ['./out/**', './.cljs_rhino_repl/**', './target/**', './.idea/**'])
endif


map <leader>uf :Unite -start-insert file_rec/async<CR>
map <leader>uj :Unite -start-insert jump<CR>
map <leader>ub :Unite -quick-match buffer<CR>
map <leader>u/ :Unite -start-insert grep:.<CR>
map <leader>uC :Unite -start-insert -input=`expand('<cword>')` grep:.<CR>
map <leader>um :Unite -smartcase mapping<CR>
map <leader>ugs :Unite -force-redraw file_rec/git:--modified:--others:--exclude-standard<CR>
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

call unite#custom#action('file', 'fugitivediff', fugitive_diff)
