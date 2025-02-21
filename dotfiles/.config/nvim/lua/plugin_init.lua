return function(vimplugins)
    spec = require('myplugin').makeargs(vimplugins)
    table.insert(spec, {import = 'plugins'})

    require('lazy').setup({
        spec = spec,
    })
end
