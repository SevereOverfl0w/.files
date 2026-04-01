return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")

    lint.linters.xlint = {
      cmd = "xlint",
      stdin = false,
      stream = "stdout",
      args = {},
      parser = require("lint.parser").from_errorformat("%f:%l: %m"),
    }

    lint.linters_by_ft.voidtemplate = { "xlint" }

    vim.api.nvim_create_autocmd({
      "BufWritePost",
      "BufReadPost",
      "InsertLeave",
      "TextChanged",
    }, {
      callback = function()
          lint.try_lint(nil, {
            filter = function(linter)
              if linter.name == "clj-kondo" then
                return #vim.lsp.get_clients({bufnr = 0, name = "clojure_lsp"}) == 0
              end
              return true
            end,
          })
      end,
    })
  end,
}
