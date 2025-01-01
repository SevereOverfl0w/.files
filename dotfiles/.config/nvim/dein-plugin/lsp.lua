vim.fn["my_plugin#add"]("neovim/nvim-lspconfig")

vim.g.LspStatus = function()
  return "[LSP" .. (#vim.lsp.buf_get_clients() > 0 and "+" or "-") .. "]"
end

vim.api.nvim_create_autocmd("User", {
  pattern = "Flags",
  callback = function()
    vim.fn.Hoist("buffer", "%!g:LspStatus()")
  end,
})

function _G.code_action_printer(code_action)
  vim.notify(vim.inspect(code_action))
  return true
end

function _G.filter_code_action(name)
  return function(code_action)
    return code_action.command.command == name
  end
end

function _G.clojure_omnifunc_lsp_fallback(...)
  if vim.fn["fireplace#op_available"]("complete") == 0 then
    return vim.lsp.omnifunc(...)
  else
    return vim.fn["fireplace#omnicomplete"](...)
  end
end

local nvim_lsp = require("lspconfig")

local cmp_loaded, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

function is_cmd_installed(lsp)
  local cmd = nvim_lsp[lsp].document_config.default_config.cmd
  -- Only present after a start:
  -- nvim_lsp[lsp].cmd[1]
  return vim.fn.executable(cmd[1]) == 1
end

vim.g.Hook_post_source_lspconfig = function()
  if is_cmd_installed("clojure_lsp") then
    nvim_lsp.clojure_lsp.setup({
      capabilities = cmp_nvim_lsp.default_capabilities(),
      settings = {
        diagnostics = true,
      },
      on_attach = function(client, bufnr)
        local function buf_set_keymap(...)
          vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        local function buf_set_option(...)
          vim.api.nvim_buf_set_option(bufnr, ...)
        end

        buf_set_option("omnifunc", "v:lua._G.clojure_omnifunc_lsp_fallback")
        vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr(#{timeout_ms:250})'
        vim.bo[bufnr].tagfunc = 'v:lua.vim.lsp.tagfunc'

        local opts = { noremap = true, silent = true }

        -- TODO: Use K, but only when fireplace isn't connected.
        buf_set_keymap("n", "<localleader>K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

        buf_set_keymap("n", "grn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

        buf_set_keymap("n", "gra", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        buf_set_keymap("v", "gra", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

        buf_set_keymap(
          "v",
          "<localleader>ef",
          '<cmd>lua vim.lsp.buf.code_action({filter = _G.filter_code_action("extract-function"), apply = true})<CR>',
          opts
        )
        buf_set_keymap(
          "v",
          "<localleader>tf",
          '<cmd>lua vim.lsp.buf.code_action({filter = _G.filter_code_action("thread-first-all"), apply = true})<CR>',
          opts
        )
        buf_set_keymap(
          "v",
          "<localleader>nsc",
          '<cmd>lua vim.lsp.buf.code_action({filter = _G.filter_code_action("clean-ns"), apply = true})<CR>',
          opts
        )
        buf_set_keymap(
          "n",
          "<localleader>lcp",
          '<cmd>lua vim.lsp.buf.code_action({filter = _G.filter_code_action("cycle-privacy"), apply = true})<CR>',
          opts
        )

        buf_set_keymap("n", "grr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

        -- I don't like that this is a loop, but in practice it should be a
        -- short loop.  Ideally I could do a O(1) mapping from client.id to
        -- diagnostic_namespace.
        for diagnostic_namespace, namespace_metadata in pairs(vim.diagnostic.get_namespaces()) do
          if namespace_metadata.name == "vim.lsp.clojure_lsp." .. client.id then
            vim.diagnostic.disable(0, diagnostic_namespace)
            break
          end
        end
      end,
      autostart = true,
    })
  end
end
