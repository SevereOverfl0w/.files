if vim.g.my_plugin_loaded_cmp then
  return
end
vim.g.my_plugin_loaded_cmp = 1

vim.fn["my_plugin#add"]('hrsh7th/nvim-cmp')
vim.fn["my_plugin#add"]('hrsh7th/cmp-nvim-lsp')
vim.fn["my_plugin#add"]('hrsh7th/cmp-buffer')
vim.fn["my_plugin#add"]('hrsh7th/cmp-emoji')

vim.g.Hook_post_source_cmp = function()
  -- TODO: set preview, or use += and base on init.vim
  vim.go.completeopt = 'menu,menuone,noselect,preview'

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

  cmp.setup.filetype({'markdown', 'gitcommit'}, {
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'emoji' },
      }
    })
end
