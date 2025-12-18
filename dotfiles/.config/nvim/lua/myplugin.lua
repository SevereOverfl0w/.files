function makeargs(vimplugins)

    luaplugins = {}

    for i, vimplugin in ipairs(vimplugins) do
        local opts = vimplugin[2] or {}
        local pluginname = vimplugin[1].name or vimplugin[1]
        local name = vim.fn.fnamemodify(vim.fn.get(vim.fn.split(pluginname, ':'), -1, ''), ':s?/$??:t:s?\\c\\.git\\s*$??')

        opts[1] = pluginname
        opts['dir'] = vimplugin[1].dir
        opts['pre_clean_name'] = name
        opts['normalized_name'] = vim.fn.substitute(vim.fn.fnamemodify(name, ':r'), '\\c^\\%(n\\?vim\\|dps\\|denops\\)[_-]\\|[_-]n\\?vim$', '', 'g')
        local hookname = vim.fn.substitute(opts['normalized_name'], '-', '_', 'g')

        if opts['depends'] then
            opts['dependencies'] = opts['depends']
        end

        local hookadd = 'Hook_add_' .. hookname
        if vim.fn['my_plugin#_is_find_function'](hookadd) == 1 then
            opts['init'] = function()
                local f = vim.g[hookadd] or vim.fn[hookadd]
                f()
            end
        end

        local hookpostsource = 'Hook_post_source_' .. hookname
        local hook_exists = vim.fn['my_plugin#_is_find_function'](hookpostsource) == 1
        if hook_exists or opts['rtp'] then
            opts['config'] = function(plugin, opts)
                if hook_exists then
                    local f = vim.g[hookpostsource] or vim.fn[hookpostsource]
                    f()
                end
                if opts['rtp'] then
                    vim.opt.rtp:append(plugin.dir .. "/" .. opts['rtp'])
                end

                if opts and next(opts) then
                    local cloned = vim.tbl_extend('error', {}, plugin)
                    local cloned_mt = vim.tbl_extend('error', {}, getmetatable(plugin))
                    cloned_mt.__index.config = nil
                    setmetatable(cloned, cloned_mt)
                    require('lazy.core.loader').config(cloned)
                end
            end
        end

        luaplugins[i] = opts
    end

    return luaplugins
end

return {
    makeargs = makeargs,
}
