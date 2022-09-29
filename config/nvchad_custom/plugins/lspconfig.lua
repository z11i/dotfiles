local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  -- lua
  "lua-language-server",
  "stylua",
  -- web
  "css-lsp",
  "html-lsp",
  "json-lsp",
  -- shell
  "shfmt",
  "shellcheck",
  -- python
  -- "python-lsp-server",
  -- go
  "gopls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
