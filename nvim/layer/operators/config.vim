let g:textobj_css_no_default_key_mappings = 1

nmap !i  <Plug>(operator-insert-i)
nmap !a  <Plug>(operator-insert-a)
map !r <Plug>(operator-replace)
xmap acr <Plug>(textobj-css-a)
omap acr <Plug>(textobj-css-a)

xmap icr <Plug>(textobj-css-i)
omap icr <Plug>(textobj-css-i)
