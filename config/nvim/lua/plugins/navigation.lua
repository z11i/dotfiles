local Util = require("lazyvim.util")
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- keys = {
    --   {
    --     "<leader>ue",
    --     function()
    --       if vim.g._neotree_side == nil then
    --         vim.g._neotree_side = "left" -- default is right
    --       else
    --         if vim.g._neotree_side == "left" then
    --           vim.g._neotree_side = "right"
    --         else
    --           vim.g._neotree_side = "left"
    --         end
    --       end
    --       require("neo-tree.command").execute({ toggle = false, position = vim.g._neotree_side })
    --     end,
    --     desc = "Toggle Neotree side",
    --   },
    -- },
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
      -- window = {
      --   position = "right",
      -- },
    },
  },
  {
    "ggandor/leap.nvim",
    keys = { "\\" },
    enabled = false,
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
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "aaronhallaert/advanced-git-search.nvim", dependencies = { "tpope/vim-fugitive" } },
      { "princejoogie/dir-telescope.nvim" },
    },
    -- apply the config and additionally load fzf-native
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("advanced_git_search")
      telescope.load_extension("dir")
    end,
    keys = {
      { "<leader>gv", "<cmd>Telescope advanced_git_search show_custom_functions<cr>", desc = "Git advanced search" },
      { "<leader>?", Util.telescope("live_grep", { cwd = false }), desc = "Find in Files (Root)" },
      { "<leader><space>", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>sp", "<cmd>Telescope dir live_grep<CR>", desc = "Grep in Path" },
      { "<leader>fp", "<cmd>Telescope dir find_files<CR>", desc = "Files in Path" },
      { "<F6>", "<cmd>Telescope fd<CR>", desc = "Telescope fd" },
    },
  },
  {
    "SmiteshP/nvim-navbuddy", -- navbuddy needs to load before lsp
    config = function()
      local navbuddy = require("nvim-navbuddy")
      navbuddy.setup({
        lsp = { auto_attach = true },
      })
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
      -- "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>nb", "<cmd>lua require('nvim-navbuddy').open()<cr>", desc = "Open navbuddy" },
    },
    cmd = { "Navbuddy" },
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = function()
      require("symbols-outline").setup()
    end,
  },
  {
    "nacro90/numb.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("numb").setup()
    end,
  },
}
