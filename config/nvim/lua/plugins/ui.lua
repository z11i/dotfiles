return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = function(_, opts)
      local integrations = {
        "lsp_trouble",
        "mason",
        "mini",
        "neotest",
        "neotree",
        "noice",
        "notify",
        "symbols_outline",
        "telescope",
        "treesitter_context",
        "which_key",
        "window_picker",
      }
      if opts["integrations"] == nil then
        opts["integrations"] = {}
      end
      for _, integration in ipairs(integrations) do
        opts["integrations"][integration] = true
      end
      opts["integrations"]["dropbar"] = { enabled = true, color_mode = true }
      opts["integrations"]["illuminate"] = { enabled = true, lsp = true }
      opts["integrations"]["navic"] = { enabled = true, color_mode = true }
    end,
  },
  -- { "rebelot/kanagawa.nvim" },
  -- { "EdenEast/nightfox.nvim" },
  -- {
  --   "maxmx03/solarized.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("solarized").setup()
  --   end,
  -- },
  {
    "folke/tokyonight.nvim",
    opts = {
      day_brightness = 0.15,
      lualine_bold = true,
    },
  },
  { "rcarriga/nvim-notify", opts = {
    render = "compact",
    top_down = false,
  } },
  {
    "akinsho/toggleterm.nvim",
    config = true,
    cmd = "ToggleTerm",
    keys = { { "<F4>", "<cmd>ToggleTerm<cr>", desc = "Toggle floating terminal" } },
    opts = {
      open_mapping = [[<F4>]],
      -- direction = "float",
      shade_filetypes = {},
      hide_numbers = true,
      insert_mappings = true,
      terminal_mappings = true,
      start_in_insert = true,
      close_on_exit = true,
    },
    dependencies = { "willothy/flatten.nvim" },
  },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>e"] = { name = "+neotree" }
      opts.defaults["<F5>"] = { name = "+run" }
      opts.defaults["<F5>r"] = { name = "+rust" }
      opts.defaults["n"] = { name = "+nav" }
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "s1n7ax/nvim-window-picker",
      config = function()
        require("window-picker").setup()
      end,
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
      nesting_rules = {
        ["go"] = {
          pattern = "(.*)%.go$", -- <-- Lua pattern with capture
          files = { "%1_test.go" }, -- <-- glob pattern with capture
        },
      },
    },
    keys = function()
      return {
        {
          "<leader>ee",
          function()
            require("neo-tree.command").execute({ toggle = true, position = "float", reveal = true })
          end,
          desc = "NeoTree Explorer",
        },
        { "<leader>E", "<leader>ee", desc = "NeoTree Explorer", remap = true },
        {
          "<leader>eb",
          function()
            require("neo-tree.command").execute({ toggle = true, position = "float", reveal = true, source = "buffers" })
          end,
          desc = "NeoTree Buffers",
        },
        {
          "<leader>eg",
          function()
            require("neo-tree.command").execute({
              toggle = true,
              position = "float",
              reveal = true,
              source = "git_status",
            })
          end,
          desc = "NeoTree Git",
        },
      }
    end,
  },
}
