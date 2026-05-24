" Shared clojure ftplugin bits, independent of nREPL client choice.

nnoremap <leader>jV :<C-U>ReplantApropos --project --private<CR>

compiler clj-lint

nmap <LocalLeader>]d <Plug>ReplantPeekSource

setlocal lispwords+=$d,<>,$
setlocal shiftwidth=2
