return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "supermaven" })
    end,
  },
  { "echasnovski/mini.comment", enabled = not vim.fn.has("nvim-0.10") == 1 },
  { "echasnovski/mini.pairs", enabled = false },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  {
    "monkoose/matchparen.nvim",
    event = "BufReadPost",
    lazy = true,
    config = function()
      require("matchparen").setup({})
    end,
  }, -- need to make sure matchparen is in lazy.lua's disabled_plugins
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.textobjects.swap = {
        enable = true,
        swap_next = {
          ["<A-l>"] = "@parameter.inner",
        },
        swap_previous = {
          ["<A-h>"] = "@parameter.inner",
        },
      }

      local move = opts.textobjects.move
      move.goto_next_start["]S"] = { query = "@scope", query_group = "locals", desc = "Next scope" }
      move.goto_previous_start["[S"] = { query = "@scope", query_group = "locals", desc = "Previous scope" }
      move.goto_next_start["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" }
      move.goto_previous_start["[z"] = { query = "@fold", query_group = "folds", desc = "Previous fold" }
    end,
  },
  {
    "karb94/neoscroll.nvim",
    enabled = false,
    keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
    opts = {
      hide_cursor = false,
      performance_mode = true,
      respect_scrolloff = true,
      stop_eof = true,
    },
    config = function()
      require("neoscroll").setup()
    end,
  },
}
