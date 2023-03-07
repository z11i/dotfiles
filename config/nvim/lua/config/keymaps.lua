-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "v" }, ";", ":")
vim.keymap.set({ "n", "v" }, ":", ";")

-- toggle background
vim.keymap.set({ "n" }, "<leader>ub", function()
  vim.cmd("set background=" .. (vim.o.background == "dark" and "light" or "dark"))
end, { desc = "Toggle background" })
