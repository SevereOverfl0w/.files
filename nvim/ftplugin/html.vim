" Prompt for Emmet shorthand
map <buffer> <localleader>ep :call emmet#expandAbbr(2,"")<cr>
" Get Emmet shorthand from buffer
map <buffer> <localleader>ee :call emmet#expandAbbr(0,"")<cr>
