" vim-terraform "fixes" syntax detection for *.tf to be
" terraform files
call my_plugin#add('hashivim/vim-terraform')

" Provides:
" - Contextual completions with deoplete support
" - Automatic linting via syntastic or neomake
" - Tagbar integration
" - Keybindings for docs
" For now I am mostly using the completion though.
call my_plugin#add('juliosueiras/vim-terraform-completion')

function! Hook_add_terraform_completion()
  " Disable slow registry search for auto-completion
  let g:terraform_module_registry_search = 0
endf
