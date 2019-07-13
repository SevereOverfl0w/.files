" vim-grepper helps you win at grep, integrated with the
" quickfix
call dein#add('mhinz/vim-grepper')

let g:grepper = {}
" Change the preferred ordering of tools, ripgrep is too
" fast to say no
let g:grepper.tools = ['rg', 'ag', 'git', 'grep']

" I took the default value for this and added
" - `-L` to follow symlinks.
" - `--hidden` to search .files
" - `-S` smart casing
" - --max-columns=150 to prevent extremely long lines
"   crashing vim
let g:grepper.rg = get(g:grepper, 'rg', {})
let g:grepper.rg.grepprg = "rg -H -L --hidden -S -g '!.git' -g '!.stversions' --max-columns=150 --no-heading --vimgrep"
let g:grepper.simple_prompt = 1

" An operator for grepping. Allows me to do `<leader>GiW` or
" `<leader>Gie`, etc. to grep for a text object.
nmap <leader>G <plug>(GrepperOperator)
xmap <leader>G <plug>(GrepperOperator)
noremap <leader>/ :<C-u>Grepper<CR>
