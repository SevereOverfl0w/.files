call my_plugin#add('sonph/onehalf', {'rtp': 'vim/'})

function! Hook_post_source_onehalf()
  if $TERM !=# 'linux'
    colorscheme onehalflight
    hi! link IncSearch PMenuSel
    hi! link ClapCurrentSelection Function
  endif
endf


