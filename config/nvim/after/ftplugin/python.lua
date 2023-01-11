-- trigger black (first in path) on save for python files
vim.api.nvim_create_user_command("Black", function()
  vim.cmd("silent !black " .. vim.fn.expand("%"))
  vim.cmd("redraw!")
end, {})
vim.api.nvim_create_autocmd({ "BufWritePost" }, { pattern = { "*.py" }, command = ":Black" })
