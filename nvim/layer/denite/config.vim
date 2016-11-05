let ignore_dirs = ['talks', 'out', '.cljs_rhino_repl', 'target', '.idea']
let ignore_file_exts = ['pack.js', 'min.css', 'min.js']

if executable('rg')
  " Use rg for denite
  " https://github.com/BurntSushi/ripgrep
  call denite#custom#var('grep', 'command', ['printargs.sh'])

  let rg_ignores = map(copy(ignore_file_exts), '"-g ''!*.".v:val."''"')
	\ + map(copy(ignore_dirs), '"-g ''!./".v:val."/**/*''"')

  call denite#custom#var('grep', 'default_opts',
			  \ ['rg', '--vimgrep', '--no-heading', '-i']
			  \ + rg_ignores)

  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])

  call denite#custom#var('file_rec', 'command', ['rg', '--files'] + rg_ignores)
endif

call denite#custom#option('default', 'prompt', ' ❯')

nnoremap <leader>d/ :Denite grep<CR>
nnoremap <leader>df :Denite file_rec<CR>
nnoremap <leader>db :Denite buffer<CR>
