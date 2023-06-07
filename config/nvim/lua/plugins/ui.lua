return {
  { "folke/tokyonight.nvim", opts = { style = "night" } },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = function()
      local integrations = {
        "illuminate",
        "leap",
        "lsp_trouble",
        "mini",
        "neotree",
        "noice",
        "notify",
        "symbols_outline",
        "telescope",
        "which_key",
      }
      for _, integration in ipairs(integrations) do
        integrations[integration] = true
      end
      return {
        background = {
          light = "latte",
          dark = "mocha",
        },
        integrations = integrations,
      }
    end,
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },
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
      direction = "float",
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
      opts.defaults["<F5>"] = { name = "+run" }
      opts.defaults["<F5>r"] = { name = "+rust" }
      opts.defaults["n"] = { name = "+nav" }
    end,
  },
}
