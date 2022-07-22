require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
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
                ["<leader>K"] = "@class.outer"
            },
        },
    },
}
