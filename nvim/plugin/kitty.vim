if exists('g:loaded_dispatch_kitty')
	finish
endif

let g:loaded_dispatch_kitty = 1

if has('nvim')
	augroup kitty-dispatch-neovim
		autocmd!
		autocmd VimEnter *
			\ if index(get(g:, 'dispatch_handlers', ['kitty']), 'kitty') < 0 |
			\	call insert(g:dispatch_handlers, 'kitty', 0) |
			\ endif
	augroup END
endif
