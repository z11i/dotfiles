return {
  {
    "tpope/vim-fugitive",
    cond = not vim.g.vscode,
    keys = {
      { "<leader>gy", "<cmd>.GBrowse!<cr>", mode = { "n" }, desc = "Copy link to current line" },
      { "<leader>gy", "<cmd>'<,'>GBrowse!<cr>", mode = { "x" }, desc = "Copy link to current selection" },
    },
    dependencies = {
      { "tpope/vim-rhubarb" },
    },
  },
}
