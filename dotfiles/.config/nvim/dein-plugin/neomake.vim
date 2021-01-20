call my_plugin#add('neomake/neomake')
call neomake#configure#automake('nrwi', 500)

let g:neomake_voidtemplate_xlint_maker = {
      \ 'exe': 'xlint',
      \ 'errorformat': '%f:%l: %m',
      \ 'auto_enabled': 1,
      \}

let g:neomake_voidtemplate_enabled_makers = ['xlint']
