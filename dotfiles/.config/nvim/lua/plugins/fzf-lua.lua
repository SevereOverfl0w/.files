local Bdelete = function(selected, opts)
    for _, s in ipairs(selected) do
        local b = s:match("%[(%d+)%]")
        vim.cmd.Bdelete(b)
    end
end

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
