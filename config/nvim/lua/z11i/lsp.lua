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

local set_keymap = function()
    local opts = { noremap=true, silent=true }
    vim.keymap.set('n', 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.keymap.set('n', '<C-k>',      '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.keymap.set('n', '<Leader>l',  '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    vim.keymap.set('n', '<F2>',       '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.keymap.set('n', '<Leader>e',  '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.keymap.set('n', 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.keymap.set('n', 'gD',         '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.keymap.set('n', 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.keymap.set('n', 'gt',         '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.keymap.set('n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.keymap.set('n', '[d',         '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.keymap.set('n', ']d',         '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    require'lsp_signature'.on_attach()
    require'virtualtypes'.on_attach()
    set_keymap()
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
local servers = {
    -- rust-analyzer is setup with rust-tools
    gopls = {
        cmd = {'gopls','--remote=auto'},
        capabilties = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        init_options = {
            usePlaceholders = true,
            completeUnimported = true
        }
    }
}
for server, config in pairs(servers) do
    lsp_config[server].setup(vim.tbl_deep_extend('force', lsp_default_config, config))
end

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
