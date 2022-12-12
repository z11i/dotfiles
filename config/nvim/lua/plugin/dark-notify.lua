local dn = require('dark_notify')
dn.run({
    schemes = {
        dark = 'tokyonight-moon',
        light = 'tokyonight-day',
    },
    onchange = function(mode)
        vim.o.background = mode
        require('plugin.feline').setup(mode)
    end
})
dn.update()
