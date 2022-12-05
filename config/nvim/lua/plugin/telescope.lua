local tls = require('telescope.builtin')
local map = require('util').map

map('n', '<leader>f', tls.find_files)
map('n', '<leader>s', tls.live_grep)
map('n', '<leader>b', tls.buffers)
map('n', '<leader>h', tls.oldfiles)
map('n', '<leader><leader>', tls.builtin)

require('telescope').setup({
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		}
	}
})
require('telescope').load_extension('fzf')
