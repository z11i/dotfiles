-- overriding nvchad default plugin configs

local M = {}

M.treesitter = {
  ensure_installed = { "all" } }

M.mason = {
  ensure_installed = {
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
    "python-lsp-server",
    -- go
    "gopls"
  }
}

return M
