" let g:deoplete#enable_at_startup = 1
" "
" let g:deoplete#sources = {}
" let g:deoplete#sources._=['ultisnips', 'file', 'dictionary']
" " let g:deoplete#sources.clojure = ['async_clj', 'ultisnips', 'file']
" let g:deoplete#sources.clojure = ['acid', 'ultisnips', 'file']
" let g:deoplete#ignore_sources = {}
" let g:deoplete#ignore_sources.clojure = ['buffer']
"
" command! AsyncCljDebug call deoplete#custom#set('async_clj', 'debug_enabled', 1) | call deoplete#enable_logging("DEBUG", "/tmp/deopletelog")

augroup CompletionGroup
  autocmd!
  autocmd CompleteDone * pclose!
augroup END
