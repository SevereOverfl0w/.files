local Bdelete = function(selected, opts)
    local path = require "fzf-lua.path"

    for _, s in ipairs(selected) do
        local entry = path.entry_to_file(s, opts)
        if entry.bufnr then
            vim.cmd.Bdelete(entry.bufnr)
        end
    end

    require('fzf-lua').resume()
end

vim.keymap.set("i", "<C-f>", function()
  require("fzf-lua").files({
    actions = {
["default"] = function(selected, opts)
  local fzf_path = require("fzf-lua.path")
  local entry = fzf_path.entry_to_file(selected[1], opts)
  local relpath = fzf_path.relative_to(entry.path, vim.uv.cwd())
  vim.api.nvim_put({ relpath }, "c", true, true)
end,    },
  })
end)

return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            "ivy",
            files = { follow = true },
            buffers = {
                actions = {
                    ["ctrl-x"] = Bdelete,
                },
            },
        },
    },
}
