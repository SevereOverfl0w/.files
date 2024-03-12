call my_plugin#add('miikanissi/modus-themes.nvim')
call my_plugin#add('sonph/onehalf', {'rtp': 'vim/'})
call my_plugin#add('https://gitlab.com/protesilaos/tempus-themes-vim.git') 
call my_plugin#add('NLKNguyen/papercolor-theme')

let s:preferred_color_scheme = get(g:, 'preferred_color_scheme', ['tempus_themes', 'tempus_day', 'tempus_night'])

let g:PaperColor_Theme_Options = {
\   'theme': {
\     'default.light': {
\       'override': {
\         'linenumber_fg': ['#111', '000']
\       }
\     }
\   }
\ }

augroup ColorOverrides
  autocmd!
  autocmd ColorScheme onehalflight hi! link IncSearch PMenuSel
  autocmd ColorScheme onehalflight hi! link ClapCurrentSelection Function
augroup END

function! ActivatePreferredColorScheme()
  if $TERM !=# 'linux'
    let &background = get(g:, 'DARKMODE', 0) ? 'dark' : 'light'
    if len(s:preferred_color_scheme) > 2
      let scheme = get(g:, 'DARKMODE', 0) ? s:preferred_color_scheme[2] :  s:preferred_color_scheme[1]
    else
      let scheme = s:preferred_color_scheme[1]
    endif
    exe 'colorscheme '.scheme
    " AutoCmds not triggered during VimEnter / other autocmds
    exe 'doautocmd ColorScheme '.scheme
  endif
endf

execute 'function! Hook_post_source_'.s:preferred_color_scheme[0]."()\n   call ActivatePreferredColorScheme()\n endf"
