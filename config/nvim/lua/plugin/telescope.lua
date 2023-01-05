local tls = require('telescope.builtin')
local map = require('util').map
local call = require('util').call
local inspect = require('inspect')


local find_files = function()
	local dir, ok = call("git rev-parse --show-toplevel")
	if ok ~= 0 then
		tls.find_files()
	else
		tls.git_files()
	end
end

map('n', '<leader>f', find_files)
map('n', '<leader>ss', tls.live_grep)
map('n', '<leader>b', tls.buffers)
map('n', '<leader>h', tls.oldfiles)
map('n', '<leader><leader>', tls.builtin)
map('n', '<leader>gc', tls.git_commits)
map('n', '<leader>gb', tls.git_branches)
map('n', '<leader>gs', tls.git_status)

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
