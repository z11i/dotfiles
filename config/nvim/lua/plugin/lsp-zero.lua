local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  	'sumneko_lua',
  	'pyright',
})

lsp.nvim_workspace({
	library = vim.api.nvim_get_runtime_file("", true),
})
lsp.setup()
