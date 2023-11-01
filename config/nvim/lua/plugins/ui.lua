return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized",
      --#region for catppuccin
      -- colorscheme = function()
      --   local integrations = {
      --     "illuminate",
      --     "leap",
      --     "lsp_trouble",
      --     "mini",
      --     "neotree",
      --     "noice",
      --     "notify",
      --     "symbols_outline",
      --     "telescope",
      --     "which_key",
      --   }
      --   for _, integration in ipairs(integrations) do
      --     integrations[integration] = true
      --   end
      --   require("catppuccin").setup({
      --     term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
      --     integrations = integrations,
      --   })
      --
      --   -- setup must be called before loading
      --   vim.cmd.colorscheme("catppuccin")
      -- end,
      --#endregion
    },
  },
  -- { "rebelot/kanagawa.nvim" },
  -- { "EdenEast/nightfox.nvim" },
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("solarized").setup({ theme = "neo" })
    end,
  },
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
      source_selector = {
        sources = {
          { source = "filesystem" },
          { source = "git_status" },
          { source = "buffers" },
          { source = "document_symbols" },
        },
      },
      window = {
        mappings = {
          ["e"] = nil, -- disable auto expand; it doesn't work with edgy
          ["<tab>"] = "toggle_node",
        },
        --   position = "right",
      },
    },
  },
}
