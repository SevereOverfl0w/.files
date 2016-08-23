function! RebaseActionToggle()
    let line = getline(".")
    let result = matchstr(line, "^\\a")
    let transitions = {'p': 'reword', 'r': 'edit', 'e': 'squash', 's': 'fixup', 'f': 'x', 'x': 'drop', 'd': 'pick'}

    execute "normal! ^cw" . transitions[result]
endfunction

noremap <buffer> <CR> :call RebaseActionToggle()<CR>
