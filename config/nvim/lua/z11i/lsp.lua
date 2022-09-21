local lsp_config = require('lspconfig')

local lsp_highlight_document = function(client)
    if client.resolved_capabilities.document_highlight then
        vim.cmd [[
        " hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        " hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        " hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceRead cterm=bold ctermbg=237 guibg=#45403d
        hi LspReferenceText cterm=bold ctermbg=237 guibg=#45403d
        hi LspReferenceWrite cterm=bold ctermbg=237 guibg=#45403d
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]]
    end
end

local opts = { noremap=true, silent=true }
vim.keymap.set('n', 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.keymap.set('n', '<C-k>',      '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.keymap.set('n', '<Leader>l',  '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
vim.keymap.set('n', '<F2>',       '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.keymap.set('n', '<Leader>e',  '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.keymap.set('n', '<Leader>A',  '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.keymap.set('n', 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.keymap.set('n', 'gD',         '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.keymap.set('n', 'gI',         '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.keymap.set('n', 'gt',         '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.keymap.set('n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.keymap.set('n', '[d',         '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.keymap.set('n', ']d',         '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    require'lsp_signature'.on_attach()
    require'virtualtypes'.on_attach()
    lsp_highlight_document(client)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local lsp_default_config = {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
}
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = {
    gopls = {
        cmd = {'gopls','--remote=auto'},
        capabilities = capabilities,
        init_options = {
            usePlaceholders = true,
            completeUnimported = true
        }
    },
    pyright = {},
    -- jedi_language_server = {}
}

for server, config in pairs(servers) do
    if server == 'pyright' then -- https://github.com/neovim/nvim-lspconfig/issues/500#issuecomment-965824580
        local lspconfig = require('lspconfig')
        -- local python_root_files = {
        --     'WORKSPACE', -- added for Bazel; items below are default
        --     'pyproject.toml',
        --     'setup.py',
        --     'setup.cfg',
        --     'requirements.txt',
        --     'Pipfile',
        --     'pyrightconfig.json',
        -- }
        local find_cmd = function(cmd, prefixes, start_from, stop_at)
            local path = require("lspconfig/util").path

            if type(prefixes) == "string" then
                prefixes = { prefixes }
            end

            local found
            for _, prefix in ipairs(prefixes) do
                local full_cmd = prefix and path.join(prefix, cmd) or cmd
                local possibility

                -- if start_from is a dir, test it first since transverse will start from its parent
                if start_from and path.is_dir(start_from) then
                    possibility = path.join(start_from, full_cmd)
                    if vim.fn.executable(possibility) > 0 then
                        found = possibility
                        break
                    end
                end

                path.traverse_parents(start_from, function(dir)
                    possibility = path.join(dir, full_cmd)
                    if vim.fn.executable(possibility) > 0 then
                        found = possibility
                        return true
                    end
                    -- use cwd as a stopping point to avoid scanning the entire file system
                    if stop_at and dir == stop_at then
                        return true
                    end
                end)

                if found ~= nil then
                    break
                end
            end

            return found or cmd
        end
        lsp_config[server].setup {
            on_attach = on_attach,
            -- root_dir = lspconfig.util.root_pattern(unpack(python_root_files)),
            before_init = function(_, config)
                local p
                if vim.env.VIRTUAL_ENV then
                    p = lspconfig.util.path.join(vim.env.VIRTUAL_ENV, "bin", "python3")
                else
                    p = find_cmd("python3", ".venv/bin", config.root_dir)
                end
                config.settings.python.pythonPath = p
            end
        }
    else
        lsp_config[server].setup(vim.tbl_deep_extend('force', lsp_default_config, config))
    end
end

require('rust-tools').setup({
    server = {
        on_attach = on_attach,
        capabilties = capabilities,
        settings = {
            -- https://rust-analyzer.github.io/manual.html#configuration
            -- https://rust-analyzer.github.io/manual.html#nvim-lsp
            ["rust-analyzer"] = {
                assist = {
                    importGranularity = "module",
                    importPrefix = "by_self",
                },
                cargo = {
                    loadOutDirsFromCheck = true,
                },
                -- rust-analyzer.procMacro.enable
                procMacro = {
                    enable = true,
                },
                lruCapacity = 1024,
                -- rust-analyzer.checkOnSave.command": "clippy"
                checkOnSave = {
                    enable = true,
                    command = "clippy",
                },
            },
        },
    }
})

-- configure diagnostics
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
})
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Python setup
vim.cmd [[
set autoread
command! Black
\   execute 'silent !black ' . expand('%')
\ | execute 'redraw!'
autocmd BufWritePost *.py execute ':Black'
autocmd FileType python setlocal shiftwidth=2 softtabstop=2 expandtab
]]
