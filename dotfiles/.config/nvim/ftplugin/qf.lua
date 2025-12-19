vim.keymap.set('n', '<S-CR>', function()
    local original_switchbuf = vim.opt.switchbuf:get()

    vim.opt.switchbuf:append { 'usetab', 'useopen' }

    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes('<CR>', true, false, true),
        'n',
        false
    )

    vim.opt.switchbuf = original_switchbuf
end, {
    buffer = true,
  }
)
