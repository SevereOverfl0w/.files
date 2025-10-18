vim.fn["my_plugin#add"]("neovim/nvim-lspconfig")
vim.fn["my_plugin#add"]("j-hui/fidget.nvim",
  {opts =
   {
     notification = {
       window =
       {
         border = "rounded"
       }
     }
   }
  })

function LspStatus(...)
  local bufnr = vim.fn.winbufnr(vim.g.statusline_winid)
  return "[LSP" .. (#vim.lsp.get_clients({bufnr = bufnr}) > 0 and "+" or "-") .. "]"
end

vim.api.nvim_create_autocmd("User", {
  pattern = "Flags",
  callback = function()
    vim.fn.Hoist("buffer", LspStatus)
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

local nvim_lsp
local cmp_loaded
local cmp_nvim_lsp

function init()
  cmp_loaded, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
end

function is_cmd_installed(lsp)
  init()
  local cmd = vim.lsp.config[lsp].cmd
  return vim.fn.executable(cmd[1]) == 1
end

vim.g.Hook_post_source_lspconfig = function()
  if is_cmd_installed("clojure_lsp") then
    init()

    -- TODO: Make Clojure-only
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        vim.bo[ev.buf].formatexpr = nil
        vim.bo[ev.buf].omnifunc = nil
        vim.keymap.del('n', 'K', { buffer = ev.buf })
      end,
    })

    function start_clojure_lsp(opts)
      local config = vim.deepcopy(vim.lsp.config['clojure_lsp'])
      local final_opts = vim.tbl_extend('force', {_root_markers = config.root_markers}, opts or {})
      if type(config.root_dir) == 'function' then
        config.root_dir(bufnr, function(root_dir)
          config.root_dir = root_dir
          vim.schedule(function()
            vim.lsp.start(config, final_opts)
          end)
        end)
      else
        vim.lsp.start(config, final_opts)
      end
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = {'clojure'}, -- in my setup only clojure_lsp is known to have this problem
      group = vim.api.nvim_create_augroup('clojure_lsp.enable', {}),
      callback = function(ev)
        -- https://github.com/neovim/neovim/issues/33061
        -- https://github.com/neovim/neovim/issues/33225
        -- Form taken from lsp.lua/lsp_enable_callback
        -- _root_markers is undocumented, but is how vim.lsp.enable() passes it in
        if not ev.file:match('^fugitive://') then
          -- vim.print('enabling for: ' .. ev.file)
          local config = vim.deepcopy(vim.lsp.config['clojure_lsp'])
          local bufnr = ev.buf
          start_clojure_lsp({bufnr = bufnr})
        end
      end,
    })

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function(ev)
        for _, file in ipairs(vim.lsp.config['clojure_lsp'].root_markers) do
          if vim.fn.filereadable(file) == 1 then
            return vim.schedule(function()
              start_clojure_lsp()
            end)
          end
        end
      end
    })

    -- Trigger for existing buffers
    vim.cmd.doautoall('clojure_lsp.enable FileType')

    vim.lsp.config('clojure_lsp', {
      capabilities = cmp_loaded and cmp_nvim_lsp.default_capabilities(),
      settings = {
        diagnostics = true,
      },
      on_attach = function(client, bufnr)
        -- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
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
          "<localleader>uw",
          '<cmd>lua vim.lsp.buf.code_action({filter = _G.filter_code_action("unwind-thread"), apply = true})<CR>',
          opts
        )
        buf_set_keymap(
          "v",
          "<localleader>ua",
          '<cmd>lua vim.lsp.buf.code_action({filter = _G.filter_code_action("unwind-all"), apply = true})<CR>',
          opts
        )

        buf_set_keymap(
          "n",
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
        vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol, opts)
        vim.keymap.set({'n', 'i'}, '<C-S>', vim.lsp.buf.signature_help, opts)

        -- I don't like that this is a loop, but in practice it should be a
        -- short loop.  Ideally I could do a O(1) mapping from client.id to
        -- diagnostic_namespace.
        for diagnostic_namespace, namespace_metadata in pairs(vim.diagnostic.get_namespaces()) do
          if namespace_metadata.name == "vim.lsp.clojure_lsp." .. client.id then
            vim.diagnostic.enable(false, {diagnostic_namespace, bufnr})
            break
          end
        end
      end,
    })
  end
end
