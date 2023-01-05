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
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gV",
            node_incremental = "vn",
            scope_incremental = "vs",
            node_decremental = "vb",
        }
    },
    indent = { enable = true },
    textobjects = {
        enable = true,
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
            }
        },
        swap = {
            enable = true,
            swap_next = {
                ["<C-s>np"] = "@parameter.inner",
                ["<C-s>nf"] = "@function.outer",
            },
            swap_previous = {
                ["<C-s>pp"] = "@parameter.inner",
                ["<C-s>pf"] = "@function.outer",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]]"] = "@function.outer",
                ["]c"] = "@class.outer",
            },
            goto_next_end = {
                ["]["] = "@function.outer",
                ["]C"] = "@class.outer",
            },
            goto_previous_start = {
                ["[["] = "@function.outer",
                ["[c"] = "@class.outer",
            },
            goto_previous_end = {
                ["[]"] = "@function.outer",
                ["[C"] = "@class.outer",
            },
        },
        -- show textobject surrounding definition as determined
        -- using Neovim's built-in LSP in a floating window
        lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
                ["<leader>K"] = "@function.outer",
                ["<leader>K"] = "@class.outer"
            },
        },
    },
})
require'treesitter-context'.setup{ enable = true, throttle = true }
