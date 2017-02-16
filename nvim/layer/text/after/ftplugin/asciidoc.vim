function! s:HeaderLevel(lnum)
  " TODO: Check syntax group to ensure it's actually a header on the line
  let l:line = getline(a:lnum)
    if l:line =~ '^== .*$'
        return 1
    endif
    if l:line =~ '^=== .*$'
        return 2
    endif
    if l:line =~ '^==== .*$'
        return 3
    endif
    if l:line =~ '^===== .*$'
        return 4
    endif
    if l:line =~ '^====== .*$'
        return 5
    endif
    if l:line =~ '^======= .*$'
        return 6
    endif

    return -1
endfunction

function! AsciidocLevel()
  let header_level = s:HeaderLevel(v:lnum)
  if header_level > 0
    return ">".header_level
  endif
  return "="
endfunction

function! AsciidocFoldText()
  let level = s:HeaderLevel(v:foldstart)
  let indent = repeat('=', level)
  let title = substitute(getline(v:foldstart), '^=\+\s*', '', '')
  let foldsize = (v:foldend - v:foldstart)
  let linecount = '['.foldsize.' line'.(foldsize>1?'s':'').']'
  return indent.' '.title.' '.linecount
endfunction

setlocal foldexpr=AsciidocLevel()
setlocal foldmethod=expr
setlocal foldtext=AsciidocFoldText()
