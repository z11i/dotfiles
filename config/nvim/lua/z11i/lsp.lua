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

    lsp_highlight_document(client)

    -- Mappings.
    local opts = { noremap=true, silent=false }
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

-- configure keymappings
vim.cmd [[
nnoremap K             :lua vim.lsp.buf.hover()<CR>
nnoremap <C-k>         :lua vim.lsp.buf.signature_help()<CR>
inoremap <C-k>         <Esc>:lua vim.lsp.buf.signature_help()<CR>a
nnoremap <Leader>l     :lua vim.lsp.buf.formatting()<CR>
nnoremap <F2>          :lua vim.lsp.buf.rename()<CR>
nnoremap <Leader>e     :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <Leader>ld    :lua vim.lsp.buf.definitions()<CR>
nnoremap <Leader>li    :lua vim.lsp.buf.implementations()<CR>
nnoremap <Leader>lt    :lua vim.lsp.buf.type_definitions()<CR>
nnoremap <Leader>lr    :lua vim.lsp.buf.references()<CR>
]]

local function lsp_highlight_document(client)
    vim.api.nvim_exec ( [[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
        ]], false)
end
