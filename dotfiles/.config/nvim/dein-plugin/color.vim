call my_plugin#add('sonph/onehalf', {'rtp': 'vim/'})

let s:preferred_color_scheme = get(g:, 'preferred_color_scheme', ['onehalf', 'onehalflight'])

function! s:custom_onehalflight()
    hi! link IncSearch PMenuSel
    hi! link ClapCurrentSelection Function
endf

function! ActivatePreferredColorScheme()
  if $TERM !=# 'linux'
    exe 'colorscheme '.s:preferred_color_scheme[1]
    try
      call function('Custom_'.s:preferred_color_scheme[1])()
    catch /E700: Unknown function.*/
    endtry
  endif
endf

execute 'function! Hook_post_source_'.s:preferred_color_scheme[0]."()\n   call ActivatePreferredColorScheme()\n endf"
