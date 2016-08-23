"          ███╗   ██╗██╗   ██╗██╗██╗      ██████╗
"          ████╗  ██║██║   ██║██║██║     ██╔═══██╗
"          ██╔██╗ ██║██║   ██║██║██║     ██║   ██║
"          ██║╚██╗██║╚██╗ ██╔╝██║██║     ██║   ██║
"          ██║ ╚████║ ╚████╔╝ ██║███████╗╚██████╔╝
"          ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚══════╝ ╚═════╝
"                          A Vimrc

let g:config_base_dir = '~/.config/nvim'

" Things that _need_ to come first
let mapleader="\<Space>"
let maplocalleader=","

" I like functional programming!
function! Mapped(fn, l)
  let new_list = deepcopy(a:l)
  call map(new_list, string(a:fn) . '(v:val)')
  return new_list
endfunction

function! LayerName(layer_path)
  return fnamemodify(a:layer_path, ":t")
endfunction

" Load layers
let g:layers = split(globpath(g:config_base_dir.'/layer', '*'), '\n')
let g:layer_names = Mapped(function("LayerName"), layers)

call plug#begin(g:config_base_dir.'/plugged')
  for l in g:layers
    let s:after = l . '/after'
    if !empty(glob(s:after))
      exe "set rtp+=" . s:after
    endif

    let s:package = l . '/package.vim'
    if filereadable(s:package)
      exe "source" s:package
    endif
  endfor
call plug#end()

" Load each layer's config
for l in g:layers
  let s:config = l . '/config.vim'
  if filereadable(s:config)
    exe "source" s:config
  endif
endfor
