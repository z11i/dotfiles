-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "v" }, ";", ":")
vim.keymap.set({ "n", "v" }, ":", ";")

-- toggle background
vim.keymap.set({ "n" }, "<leader>ub", function()
  vim.cmd("set background=" .. (vim.o.background == "dark" and "light" or "dark"))
end, { desc = "Toggle background" })

-- system clipboard
vim.keymap.set({ "n", "v" }, "<leader>yy", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>yp", '"+p', { desc = "Paste from system clipboard" })

-- copy file path to clipboard
vim.keymap.set({ "n" }, "<leader>y/", function()
  local file_path = vim.fn.expand("%:p")
  vim.fn.setreg("+", file_path)
  print("Copied file path to clipboard: " .. file_path)
end, { desc = "Copy absolute file path" })

-- copy relative file path to root to clipboard
vim.keymap.set({ "n" }, "<leader>y.", function()
  local relative_path = vim.fn.expand("%:~:.")
  vim.fn.setreg("+", relative_path)
  print("Copied relative file path to clipboard: " .. relative_path)
end, { desc = "Copy relative file path" })

-- Tab and S-Tab to cycle through buffers
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
