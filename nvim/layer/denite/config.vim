let ignore_dirs = ['talks', 'out', '.cljs_rhino_repl', 'target', '.idea']
let ignore_file_exts = ['pack.js', 'min.css', 'min.js']

if executable('rg')
  " Use rg for denite
  " https://github.com/BurntSushi/ripgrep
  call denite#custom#var('grep', 'command', ['rg'])

  let rg_ignores = map(copy(ignore_file_exts), '"!*.".v:val')
	\ + map(copy(ignore_dirs), '"!./".v:val."/**/*"')

  let rg_ignore_args = []
  for i in rg_ignores
    let rg_ignore_args = rg_ignore_args + ['-g', i]
  endfor

  call denite#custom#var('grep', 'default_opts',
			  \ ['--vimgrep', '--no-heading', '-i']
			  \ + rg_ignore_args)

  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])

  call denite#custom#var('file_rec', 'command', ['rg', '--files'] + rg_ignore_args)
endif

call denite#custom#option('default', 'prompt', ' ❯')

nnoremap <leader>d/ :Denite grep<CR>
nnoremap <leader>df :Denite file_rec<CR>
nnoremap <leader>db :Denite buffer<CR>
nnoremap <leader>dh :Denite help<CR>
