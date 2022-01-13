vim.opt.expandtab = false
vim.opt.shiftwidth=4
vim.opt.softtabstop=4
vim.opt.tabstop=4

vim.cmd [[autocmd BufWritePre *.go :lua require('go.format').goimport()]]

require 'go'.setup({
    goimport = 'gopls', -- if set to 'gopls' will use golsp format
    gofmt = 'gopls', -- if set to gopls will use golsp format
    max_line_len = 120,
    tag_transform = false,
    test_dir = '',
    comment_placeholder = '<>',
    lsp_cfg = false, -- false: use your own lspconfig
    lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
    lsp_on_attach = false, -- use on_attach from go.nvim
    lsp_codelens = true,
    dap_debug = true,
})

local protocol = require'vim.lsp.protocol'
