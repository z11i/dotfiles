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
