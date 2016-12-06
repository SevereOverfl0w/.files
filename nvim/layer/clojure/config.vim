let g:rainbow_active = 1
let g:clojure_special_indent_words = 'deftype,defrecord,reify,proxy,extend-type,extend-protocol,letfn,defcomponent'
let g:clojure_maxlines = 0
setlocal lispwords+=go-loop,try-n-times,fdef

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.#]*'

if !exists('g:test_terminal_id')
  let g:test_terminal_id = -2
endif

function! s:GetOrMakeTerm()
  if g:test_terminal_id <= 0 || jobwait([g:test_terminal_id], 0)[0] <= -2
    botright new
    resize 7
    set wfh
    let g:test_terminal_id = termopen('boot repl -c')
  endif
  return g:test_terminal_id
endfunction

function! s:RunAllMyTests(myarg)
  " call jobsend(s:GetOrMakeTerm(), ["(require 'dev) (dev/run-all-my-tests)", ""])
  call jobsend(s:GetOrMakeTerm(), ["(require 'eftest.runner) (eftest.runner/run-tests (eftest.runner/find-tests " . a:myarg . ") {:multithread? false})", ""])
endfunction

command! -nargs=* RunDevTests :call s:RunAllMyTests(<q-args>)

function! s:ReplDoc(symbol)
  exec "Eval (clojure.repl/doc " a:symbol ")"
endfunction

nnoremap <silent> RK :call <SID>ReplDoc(expand('<cword>'))<CR>

function! FindSymbol(symbol, ns, curr_file, pos)
  let info = get(fireplace#message({'op': 'info', 'symbol': a:symbol, 'ns': a:ns}), 0, {})

  let response = fireplace#message({'op': 'find-symbol', 'dir': getcwd(), 'file': a:curr_file, 'ns': get(info, 'ns', a:ns), 'name': get(info, 'name', a:symbol), 'line': a:pos[1], 'column': a:pos[2], 'serialization-format': 'bencode'})

  let occurences = []

  " echo response
  for x in response
    if has_key(x, 'occurrence')
      call add(occurences, x['occurrence'])
    endif
  endfor

  return occurences
endfunction

command! FindSymbol :echo FindSymbol(expand('<cword>'), fireplace#ns(), expand('%:p'), getpos('.'))

function! s:unite_find_symbol(args, context)
  let candidates = []
  let occurrences = FindSymbol(a:context.source__symbol,
                             \ a:context.source__ns,
                             \ a:context.source__curr_file,
                             \ a:context.source__pos)

  for o in occurrences
    call add(candidates, {
          \ 'word': printf('%s:%s %s', fnamemodify(o['file'], ':~:.'),
          \                o['line-beg'] . (o['col-beg'] != 0 ? ':'.o['col-beg'] : ''),
          \                split(o['match'], '\n')[0]),
          \ 'action__path': o['file'],
          \ 'action__line': o['line-beg'],
          \ 'action__col': o['col-beg']
          \ })
  endfor

  return candidates
endfunction

function! s:unite_find_symbol_init(args, context)
  let a:context.source__symbol = expand('<cword>')
  let a:context.source__ns = fireplace#ns()
  let a:context.source__curr_file = expand('%:p')
  let a:context.source__pos = getpos('.')
endfunction

function! s:unite_find_symbol_syntax(args, context)
  let info = fireplace#message({'op': 'info', 'symbol': a:context.source__symbol, 'ns': a:context.source__ns})[0]
  syntax case ignore
  syntax match uniteSource__FSHeader /[^:]*:\d\+:\(\d\+ \)\?/
  execute 'syntax match uniteSource__FSPattern /'
        \ . substitute(info['name'], '\([/\\]\)', '\\\1', 'g')
        \ . '/'
  highlight default link uniteSource__FSHeader Comment

  execute 'highlight default link uniteSource__FSPattern'
        \ get(a:context, 'custom_grep_search_word_highlight',
        \ g:unite_source_grep_search_word_highlight)
endfunction

function! s:unite_find_symbol_syntax(args, context)
  let info = fireplace#message({'op': 'info', 'symbol': a:context.source__symbol, 'ns': a:context.source__ns})[0]
  syntax case ignore
  syntax match uniteSource__FSHeader /[^:]*: \d\+: \(\d\+: \)\?/ contained
        \ containedin=uniteSource__FS
  syntax match uniteSource__FSFile /[^:]*: / contained
        \ containedin=uniteSource__FSHeader
        \ nextgroup=uniteSource__FSLineNR
  syntax match uniteSource__FSLineNR /\d\+: / contained
        \ containedin=uniteSource__FSHeader
        \ nextgroup=uniteSource__FSPattern
  " execute 'syntax match uniteSource__FSPattern /'
  "       \ . substitute(info['name'], '\([/\\]\)', '\\\1', 'g')
  "       \ . '/ contained containedin=uniteSource__FS'
  syntax match uniteSource__FSSeparator /:/ contained conceal
        \ containedin=uniteSource__FSFile,uniteSource__FSLineNR
  highlight default link uniteSource__FSFile Comment
  highlight default link uniteSource__FSLineNr LineNR
  execute 'highlight default link uniteSource__FSPattern'
        \ get(a:context, 'custom_grep_search_word_highlight',
        \ g:unite_source_grep_search_word_highlight)
endfunction

call unite#define_source({
      \ 'name': 'clj_find_symbol',
      \ 'gather_candidates': function('s:unite_find_symbol'),
      \ 'hooks': {'on_init': function('s:unite_find_symbol_init'),
                \ 'on_syntax': function('s:unite_find_symbol_syntax')},
      \ 'syntax' : 'uniteSource__FS',
      \ 'default_kind': 'jump_list',
      \ 'description': 'Find usages of symbol for Clojure using nrepl'
      \ })
