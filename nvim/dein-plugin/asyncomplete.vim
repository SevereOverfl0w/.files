if exists('g:my_plugin_loaded_asyncomplete')
  finish
endif

call dein#add('prabirshrestha/asyncomplete.vim')

au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'fireplace',
    \ 'whitelist': ['clojure'],
    \ 'completor': function('async_clj_omni#sources#complete'),
    \ })

let g:asyncomplete_auto_completeopt = 0
