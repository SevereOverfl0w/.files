let g:EasyMotion_do_mapping = 0
let g:EasyMotion_skipfoldedline = 0

let g:textobj_css_no_default_key_mappings = 1

map <leader>jk <Plug>(signjk-jk)
map <leader>jl <Plug>(easymotion-bd-jk)
map <leader>jw <Plug>(easymotion-bd-w)
map <leader>jf <Plug>(easymotion-bd-f)


nmap !i  <Plug>(operator-insert-i)
nmap !a  <Plug>(operator-insert-a)
map !r <Plug>(operator-replace)
xmap acr <Plug>(textobj-css-a)
omap acr <Plug>(textobj-css-a)

xmap icr <Plug>(textobj-css-i)
omap icr <Plug>(textobj-css-i)
