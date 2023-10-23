return {
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    dependencies = { "junegunn/fzf" },
    opts = {
      auto_resize_height = true,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.sections.lualine_b = {} -- disable git branch
      table.remove(opts.sections.lualine_c) -- remove nvim-navic
      table.remove(opts.sections.lualine_c) -- remove Util.lualine.pretty_path() because it's not adjustable, and defaults to hide too much
      table.insert(opts.sections.lualine_c, { "filename", path = 2 }) -- use lualine default absolute path
    end,
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "slant", -- sublime text style
        -- do not show no. of errors and warnings
        diagnostics_indicator = function(_, _, diag)
          local icons = require("lazyvim.config").icons.diagnostics
          local ret = (diag.error and icons.Error or "") .. (diag.warning and icons.Warn or "")
          return vim.trim(ret)
        end,
      },
    },
  },
  {
    "utilyre/barbecue.nvim",
    enabled = false,
    name = "barbecue",
    version = "*",
    dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("barbecue").setup({ show_dirname = false, theme = "catppuccin" })
      require("barbecue.ui").toggle(true)
    end,
  },
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    keys = {
      {
        "<leader>nf",
        function()
          require("dropbar.api").fuzzy_find_toggle()
        end,
        desc = "Fuzzy find in dropbar",
      },
      {
        "<leader>nt",
        function()
          require("dropbar.api").pick()
        end,
        desc = "Select dropbar",
      },
    },
  },
}
