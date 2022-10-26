local autocmd = vim.api.nvim_create_autocmd
-- autocmd BufWritePost *.py execute ':Black'
-- autocmd FileType python setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd({ "BufWritePost" }, {
  pattern = { "*.py" },
  callback = function ()
    vim.lsp.buf.format({async=true})
  end
})

autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})
