local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    require'lsp_signature'.on_attach()
    require'virtualtypes'.on_attach()

    -- Mappings.
    local opts = { noremap=true, silent=false }

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<leader>l", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<leader>l", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- > Rust is setup with rust-tools
local servers = { 'gopls' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }
end

require('rust-tools').setup({})

require('lsp_signature').setup()

-- highlighting
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
                ["<C-s><C-p>"] = "@parameter.inner",
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

-- configure diagnostics
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
})
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
