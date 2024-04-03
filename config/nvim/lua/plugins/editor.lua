return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          -- copied from cmp-under
          function(entry1, entry2)
            local _, entry1_under = entry1.completion_item.label:find("^_+")
            local _, entry2_under = entry2.completion_item.label:find("^_+")
            entry1_under = entry1_under or 0
            entry2_under = entry2_under or 0
            if entry1_under > entry2_under then
              return false
            elseif entry1_under < entry2_under then
              return true
            end
          end,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      }
    end,
  },
  { "echasnovski/mini.pairs", enabled = false },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "HiPhish/rainbow-delimiters.nvim" },
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
}
