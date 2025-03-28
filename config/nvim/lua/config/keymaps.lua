-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.keymap.set({ "n", "v" }, ";", ":")
-- vim.keymap.set({ "n", "v" }, ":", ";")

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

-- Ctrl-, and Ctrl-. to cycle through buffers
vim.keymap.set({ "n", "i" }, "<C-,>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
vim.keymap.set({ "n", "i" }, "<C-.>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

-- Tab to switch last used buffer
vim.keymap.set({ "n" }, "<Tab>", "<cmd>b#<cr>", { desc = "Switch to last used buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { desc = "Switch buffers" })

-- Ctrl-arrows defined in LazyVim conflict with mac
vim.keymap.del("n", "<C-Up>")
vim.keymap.del("n", "<C-Down>")
vim.keymap.del("n", "<C-Left>")
vim.keymap.del("n", "<C-Right>")
-- Resize window using <Alt> arrow keys
vim.keymap.set("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

if vim.g.vscode then
  vim.keymap.set("n", "j", "<cmd>call VSCodeCall('cursorDown')<cr>", { desc = "VSCode cursor down", remap = true })
  vim.keymap.set("n", "k", "<cmd>call VSCodeCall('cursorUp')<cr>", { desc = "VSCode cursor up", remap = true })
end
