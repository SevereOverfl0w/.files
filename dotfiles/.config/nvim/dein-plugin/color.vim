call my_plugin#add('sonph/onehalf', {'rtp': 'vim/'})
call my_plugin#add('https://gitlab.com/protesilaos/tempus-themes-vim.git') 
call my_plugin#add('NLKNguyen/papercolor-theme')

let s:preferred_color_scheme = get(g:, 'preferred_color_scheme', ['onehalf', 'onehalflight'])

let g:PaperColor_Theme_Options = {
\   'theme': {
\     'default.light': {
\       'override': {
\         'linenumber_fg': ['#111', '000']
\       }
\     }
\   }
\ }

function! s:custom_PaperColor()
endf

function! s:custom_onehalflight()
    hi! link IncSearch PMenuSel
    hi! link ClapCurrentSelection Function
endf

function! ActivatePreferredColorScheme()
  if $TERM !=# 'linux'
    exe 'colorscheme '.s:preferred_color_scheme[1]
    try
      let F = function('<sid>custom_'.s:preferred_color_scheme[1])
    catch /E700: Unknown function.*/
      return
    endtry
    call F()
  endif
endf

execute 'function! Hook_post_source_'.s:preferred_color_scheme[0]."()\n   call ActivatePreferredColorScheme()\n endf"
