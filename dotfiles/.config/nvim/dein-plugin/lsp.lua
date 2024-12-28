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

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, silent = true }

  -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

  -- TODO: I'm not sure I want to replace doc always, e.g. for clojure or vimscript!
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("v", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local cmp_loaded, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local servers = { "zk" }

function is_cmd_installed(lsp)
  local cmd = nvim_lsp[lsp].document_config.default_config.cmd
  -- Only present after a start:
  -- nvim_lsp[lsp].cmd[1]
  return vim.fn.executable(cmd[1]) == 1
end

vim.g.Hook_post_source_lspconfig = function()
  for _, lsp in ipairs(servers) do
    opts = {
      on_attach = on_attach,
      autostart = true,
    }

    if cmp_loaded then
      opts.capabilities = cmp_nvim_lsp.default_capabilities()
    end
    if is_cmd_installed(lsp) then
      nvim_lsp[lsp].setup(opts)
    end
  end

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

        local opts = { noremap = true, silent = true }

        -- TODO: Use gs, but only when fireplace isn't connected.
        buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        -- Fireplace is already using <C-w>gd
        buf_set_keymap("n", "<C-w>gs", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", opts)
        -- TODO: Use K, but only when fireplace isn't connected.
        buf_set_keymap("n", "<localleader>K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

        buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

        buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        buf_set_keymap("v", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

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

        buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

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
