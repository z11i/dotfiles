require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	sync_install = false,
	highlight = {
		enable = true,
		disable = function(lang, buf)
			local max_size = 10 * 1024 * 1024 -- 10 MiB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_size then
				return true
			end
		end,
		additional_vim_regex_highlighting = false, -- or a list of langs
	},
})
