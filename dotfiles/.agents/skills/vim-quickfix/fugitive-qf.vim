function! g:ClaudeQfFugitiveText(info) abort
  let items = getqflist({'id': a:info.id, 'items': 1}).items
  let l = []
  for idx in range(a:info.start_idx - 1, a:info.end_idx - 1)
    let e = items[idx]
    let name = bufname(e.bufnr)
    let m = matchlist(name, '//\([0-9a-f]\{40\}\)/\(.*\)')
    if len(m) > 2
      let display = m[1][:6] . ':' . m[2]
    else
      let display = name
    endif
    call add(l, display . '|' . e.lnum . '| ' . e.text)
  endfor
  return l
endfunction
