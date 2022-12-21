require'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = "auto",
        section_separators = { left = '', right = ''},
        component_separators = { left = '', right = ''},
        disabled_filetypes = {'aerial'},
        globalstatus = true,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {
            {'filename', file_status = true, path = 1},
        },
        lualine_x = {'filetype', {
            'diagnostics',
            sources = {'nvim_diagnostic'},
            sections = {'error', 'warn', 'info', 'hint'},
            symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '},
            colored = true,
            update_in_insert = true,
            always_visible = false}
    	},
    	lualine_y = {'progress'},
    	lualine_z = {'location'},
	},
	inactive_sections = {
    	lualine_a = {},
    	lualine_b = {},
    	lualine_c = {'filename'},
    	lualine_x = {'location'},
    	lualine_y = {},
    	lualine_z = {}
	},
	tabline = {},
	extensions = {'quickfix', 'nvim-tree', 'fugitive'}
}
