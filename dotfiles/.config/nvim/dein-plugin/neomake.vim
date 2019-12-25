call my_plugin#add('neomake/neomake')
call neomake#configure#automake('nrwi', 500)

let g:neomake_clojure_kondo_maker = {
      \ 'exe': 'clj-kondo',
      \ 'args': ['--lint'],
      \ 'errorformat': '%f:%l:%c: Parse %t%*[^:]: %m,%f:%l:%c: %t%*[^:]: %m',
      \}

let g:neomake_clojure_joker_maker = {
      \ 'exe': 'joker',
      \ 'args': ['--lint'],
      \ 'errorformat': '%f:%l:%c: Parse %t%*[^:]: %m,%f:%l:%c: %t%*[^:]: %m',
      \}

let g:neomake_clojure_enabled_makers = ['kondo', 'joker']
