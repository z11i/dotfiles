require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
    },
    incremental_selection = { enable = true },
    indent = { enable = true },
    textobjects = {
        enable = true,
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["as"] = "@class.outer",
                ["is"] = "@class.inner",
            }
        },
        swap = {
            enable = true,
            swap_next = {
                ["<C-s><C-n>"] = "@parameter.inner",
            },
            swap_previous = {
                ["<C-s><C-p>"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]]"] = "@function.outer",
                ["]f"] = "@function.outer",
                ["]s"] = "@class.outer",
            },
            goto_next_end = {
                ["]["] = "@function.outer",
                ["]F"] = "@function.outer",
                ["]S"] = "@class.outer",
            },
            goto_previous_start = {
                ["[["] = "@function.outer",
                ["[f"] = "@function.outer",
                ["[s"] = "@class.outer",
            },
            goto_previous_end = {
                ["[]"] = "@function.outer",
                ["[F"] = "@function.outer",
                ["[S"] = "@class.outer",
            },
        },
        -- show textobject surrounding definition as determined
        -- using Neovim's built-in LSP in a floating window
        lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
                ["<leader>K"] = "@function.outer",
            },
        },
    },
}
