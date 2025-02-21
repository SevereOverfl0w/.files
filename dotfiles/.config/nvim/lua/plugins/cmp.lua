return {
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return {
        mapping = require("cmp").mapping.preset.insert(),
        sources = {
          { name = "buffer" },
          { name = "async_clj_omni" },
          { name = "nvim_lsp" },
        },
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
      }
    end,
    init = function()
      -- TODO: set preview, or use += and base on init.vim
      vim.go.completeopt = "menu,menuone,noselect,preview"
    end,
    enabled = not vim.g.my_plugin_loaded_cmp,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)
      cmp.setup.filetype({ "markdown", "gitcommit" }, {
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "emoji" },
        },
      })
    end,
  },
  {"hrsh7th/cmp-nvim-lsp", enabled = not vim.g.my_plugin_loaded_cmp},
  {"hrsh7th/cmp-buffer", enabled = not vim.g.my_plugin_loaded_cmp},
  {"hrsh7th/cmp-emoji", enabled = not vim.g.my_plugin_loaded_cmp},
}
