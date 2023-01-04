require("leap").setup({
	case_sensitive = false,
})

local map = require("util").map
map("n", "\\", function()
	require("leap").leap({
		target_windows = vim.tbl_filter(
		function(win) return vim.api.nvim_win_get_config(win).focusable end,
		vim.api.nvim_tabpage_list_wins(0)
		)})
	end)
require('flit').setup { }

