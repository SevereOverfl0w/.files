call my_plugin#add('sonph/onehalf', {'rtp': 'vim/'})

function! Hook_post_source_onehalf()
  colorscheme onehalflight
  hi! link IncSearch PMenuSel
endf


