if exists('g:autoloaded_dispatch_kitty')
	finish
endif

let g:autoloaded_dispatch_kitty = 1

function! dispatch#kitty#handle(request) abort
	if empty($KITTY_LISTEN_ON)
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

	call system(kitty.' '.&shell.' '.&shellcmdflag.' '.shellescape(command).redir)
	return !v:shell_error
endfunction

function! dispatch#kitty#activate(pid) abort
  let out = system('ps ewww -p '.a:pid)
  let listen_on = matchstr(out, 'KITTY_LISTEN_ON=\zs\S\+')
  let call = 'kitty @ '
  if !empty(listen_on)
    let call .= '--to '. listen_on . ' '
  endif
  let call .= 'focus-window --match pid:'. a:pid
  call system(call)
  return !v:shell_error
endfunction
