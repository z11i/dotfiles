return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin",
      colorscheme = "tokyonight",
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

      opts["term_colors"] = true

      return opts
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
    tag = "v3.0.1", -- # v4 does not auto choose light theme. Sticking with v3 until that is fixed.
    opts = {
      style = "night",
      light_style = "day",
      day_brightness = 0.3,
      lualine_bold = true,
      on_highlights = function(hl, c)
        hl.MatchParen = { bg = c.fg_gutter, bold = true }

        -- borderless telescope
        local prompt = "#2d3149"
        hl.TelescopeNormal = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
          bg = prompt,
        }
        hl.TelescopePromptBorder = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePromptTitle = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePreviewTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }

        -- flash label is hard to see in light mode
        hl.FlashLabel = {
          fg = c.red1,
          bg = c.fg_gutter,
          bold = true,
        }
      end,
    },
  },
  { "rcarriga/nvim-notify", opts = {
    render = "compact",
    top_down = false,
  } },
  {
    "akinsho/toggleterm.nvim",
    enabled = false,
    config = true,
    cmd = "ToggleTerm",
    keys = {
      { "<F4>", "<cmd>ToggleTerm<cr>", desc = "ToggleTerm" },
      { "<leader>wh", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle horizontal terminal" },
      { "<leader>wv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Toggle vertical terminal" },
      { "<leader>wf", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
    },
    opts = {
      open_mapping = [[<F4>]],
      direction = "horizontal",
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
      opts.defaults["\\"] = { name = "+Harpoon" }
    end,
  },
  {
    "echasnovski/mini.files",
    opts = { options = { use_as_default_explorer = true } },
    keys = {
      {
        "<leader>ee",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "<leader>eE",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
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
          files = { "%1_test.go", "%1_mock.go" }, -- <-- glob pattern with capture
        },
      },
      window = {
        mappings = {
          ["<C-i>"] = { "toggle_node" },
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
  {
    "NvChad/nvim-colorizer.lua",
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
      "ColorizerToggle",
    },
    config = function()
      require("colorizer").setup({})
    end,
  },
}
