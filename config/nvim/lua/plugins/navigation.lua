return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_ignored = false,
          hide_hidden = false,
        },
        never_show = {
          ".DS_Store",
        },
      },
    },
  },
  {
    "ggandor/leap.nvim",
    keys = { "\\" },
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
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    -- apply the config and additionally load fzf-native
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
  },
}
