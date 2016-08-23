function! DeopleteDoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', {'do': function('DeopleteDoRemote')}
