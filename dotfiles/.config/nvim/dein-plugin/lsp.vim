call my_plugin#add('neovim/nvim-lspconfig')

function! Hook_post_source_lspconfig()

  lua << EOF
  function _G.clojure_omnifunc_lsp_fallback(...)
    if vim.fn['fireplace#op_available']('complete') == 0 then
      return vim.lsp.omnifunc(...)
    else
      return vim.fn['fireplace#omnicomplete'](...)
    end
  end


  local nvim_lsp = require('lspconfig')

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }

    -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

    -- TODO: I'm not sure I want to replace doc always, e.g. for clojure or vimscript!
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

    -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  end

  local cmp_loaded, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  local servers = { 'zk', 'tsserver' }
  for _, lsp in ipairs(servers) do
    opts = {
      on_attach = on_attach,
      autostart = true
    }

    if cmp_loaded then
      opts.capabilities = cmp_nvim_lsp.default_capabilities()
    end
    nvim_lsp[lsp].setup(opts)
  end

  nvim_lsp.clojure_lsp.setup{
    settings = {
      diagnostics = true,
    },
    on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      buf_set_option('omnifunc', 'v:lua._G.clojure_omnifunc_lsp_fallback')

      local opts = { noremap=true, silent=true }

      -- TODO: Use gs, but only when fireplace isn't connected.
      buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      -- Fireplace is already using <C-w>gd
      buf_set_keymap('n', '<C-w>gs', '<cmd>tab split | lua vim.lsp.buf.definition()<CR>', opts)
      -- TODO: Use K, but only when fireplace isn't connected.
      buf_set_keymap('n', '<localleader>K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

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
  }
EOF
  LspStart

endfunction
