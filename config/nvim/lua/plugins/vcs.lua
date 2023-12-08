return {
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gy", "<cmd>.GBrowse!<cr>", mode = { "n" }, desc = "Copy link to current line" },
      { "<leader>gy", "<cmd>'<,'>GBrowse!<cr>", mode = { "x" }, desc = "Copy link to current selection" },
    },
    dependencies = {
      { "tpope/vim-rhubarb" },
    },
  },
}
