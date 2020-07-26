call my_plugin#add('neomake/neomake')
call neomake#configure#automake('nrwi', 500)

let g:neomake_clojure_kondo_maker = {
      \ 'exe': 'clj-kondo',
      \ 'args': ['--lint'],
      \ 'errorformat': '%f:%l:%c: Parse %t%*[^:]: %m,%f:%l:%c: %t%*[^:]: %m',
      \ 'auto_enabled': 1,
      \}

let g:neomake_clojure_joker_maker = {
      \ 'exe': 'joker',
      \ 'args': ['--lint'],
      \ 'errorformat': '%f:%l:%c: Parse %t%*[^:]: %m,%f:%l:%c: %t%*[^:]: %m',
      \ 'auto_enabled': 1,
      \}

let g:neomake_clojure_enabled_makers = ['kondo', 'joker']

let g:neomake_voidtemplate_xlint_maker = {
      \ 'exe': 'xlint',
      \ 'errorformat': '%f:%l: %m',
      \ 'auto_enabled': 1,
      \}

let g:neomake_voidtemplate_enabled_makers = ['xlint']
