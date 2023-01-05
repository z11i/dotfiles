local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')
local find_cmd = require('util').find_cmd

lsp.preset('recommended')

lsp.nvim_workspace({
	library = vim.api.nvim_get_runtime_file("", true),
})

-- lsp.configure('pylsp', {
--     settings = {
--         pylsp = {
--             plugins = {
--                 pycodestyle = {
--                     enabled = false,
--                 },
--             }
--         }
--     }
-- })

lsp.configure('pyright', { -- https://github.com/neovim/nvim-lspconfig/issues/500#issuecomment-965824580
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                exclude = {
                    "**/__pycache__",
                },
            }
        }
    },
    before_init = function(_, config)
        local p
        if vim.env.VIRTUAL_ENV then
            p = lspconfig.util.path.join(vim.env.VIRTUAL_ENV, "bin", "python3")
        else
            p = find_cmd("python3", ".venv/bin", config.root_dir)
        end
        config.settings.python.pythonPath = p
    end
})

lsp.setup()
