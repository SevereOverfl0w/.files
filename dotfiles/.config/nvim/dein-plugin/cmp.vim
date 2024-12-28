if exists('g:my_plugin_loaded_cmp')
  finish
endif

call my_plugin#add('hrsh7th/nvim-cmp')
call my_plugin#add('hrsh7th/cmp-nvim-lsp')
call my_plugin#add('hrsh7th/cmp-buffer')

function! Hook_post_source_cmp()
  " TODO: set preview, or use += and base on init.vim
  set completeopt=menu,menuone,noselect,preview

  lua <<EOF
local cmp = require'cmp'

cmp.setup({
  mapping = cmp.mapping.preset.insert(),
  sources = {
    { name = 'buffer' },
    { name = 'async_clj_omni' },
    { name = 'nvim_lsp' },
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
    },
})

cmp.setup.filetype({'markdown'}, {
  sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'emoji' },
    }
  })
EOF
endfunction
