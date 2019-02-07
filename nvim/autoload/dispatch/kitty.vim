if exists('g:autoloaded_dispatch_kitty')
	finish
endif

let g:autoloaded_dispatch_kitty = 1

function! dispatch#kitty#handle(request) abort
  echom string(a:request)
	if $KITTY_LISTEN_ON == ''
	  return 0
	endif

	if a:request.action ==# 'make'
	  " Using it for make is annoying (for now)
	  return 0
	  let command = dispatch#prepare_make(a:request)
	elseif a:request.action ==# 'start'
	  let command = dispatch#prepare_start(a:request)
	else
	  return 0
	endif

	if &shellredir =~# '%s'
	    let redir = printf(&shellredir, '/dev/null')
	  else
	    let redir = &shellredir . ' ' . '/dev/null'
	endif

	let kitty = 'kitty @ new-window --title='.shellescape(a:request.title).' '.'--cwd='.shellescape(a:request.directory)

	if a:request.action ==# 'start'
	  let kitty .= ' --new-tab --tab-title='.shellescape(a:request.title)
	endif

	if a:request.background
	  let kitty .= ' --keep-focus'
	endif

	echom kitty.' '.&shellcmdflag.' '.shellescape(command).redir
	call system(kitty.' '.&shell.' '.&shellcmdflag.' '.shellescape(command).redir)
	return !v:shell_error
endfunction

function! dispatch#kitty#activate(pid) abort
  echom 'Focused '.a:pid
endfunction

function! dispatch#kitty#activate(pid) abort
  return 0
endfunction
