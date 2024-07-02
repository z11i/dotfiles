-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.relativenumber = false
if vim.fn.has("nvim-0.9.0") == 1 then
  vim.o.exrc = true
end
vim.opt.clipboard = ""
-- set word soft wrap
vim.opt.wrap = true
-- show character before wrapped lines
vim.opt.showbreak = [[    ⤷]]
-- make wrapped lines continue visually indented
vim.opt.breakindent = true
-- wrap line at word boundary
vim.opt.linebreak = true

vim.opt.mousemoveevent = true

-- show matching brackets
vim.opt.showmatch = true
vim.opt.matchtime = 2

-- LazyVim will try to use LSP to configure the root, which is not convenient.
vim.g.root_spec = { { ".git", "lua" }, "cwd" }
