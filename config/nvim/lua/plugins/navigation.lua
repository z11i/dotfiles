return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>ue",
        function()
          if vim.g._neotree_side == nil then
            vim.g._neotree_side = "left" -- default is right
          else
            if vim.g._neotree_side == "left" then
              vim.g._neotree_side = "right"
            else
              vim.g._neotree_side = "left"
            end
          end
          require("neo-tree.command").execute({ toggle = false, position = vim.g._neotree_side })
        end,
        desc = "Toggle Neotree side",
      },
    },
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
      window = {
        position = "right",
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
      telescope.load_extension("advanced_git_search")
    end,
    keys = {
      { "<leader>gv", "<cmd>Telescope advanced_git_search show_custom_functions<cr>", desc = "Git advanced search" },
    },
  },
  {
    "SmiteshP/nvim-navbuddy",
    config = function()
      local navbuddy = require("nvim-navbuddy")
      navbuddy.setup({
        lsp = { auto_attach = true },
      })
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>n", "<cmd>lua require('nvim-navbuddy').open()<cr>", desc = "Open navbuddy" },
    },
    cmd = { "Navbuddy" },
  },
}
