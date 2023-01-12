return {
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").setup({
        case_sensitive = false,
      })
      vim.keymap.set("n", "\\", function()
        require("leap").leap({
          target_windows = vim.tbl_filter(function(win)
            return vim.api.nvim_win_get_config(win).focusable
          end, vim.api.nvim_tabpage_list_wins(0)),
        })
      end)
      require("flit").setup({}) -- f/t motions
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    config = function()
      require("window-picker").setup()
    end,
  },
}
