return {
  { "kevinhwang91/nvim-bqf", ft = "qf", dependencies = { "junegunn/fzf" } },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.sections.lualine_b = {} -- disable git branch
      --#region remove nvim-navic from statusline: https://github.com/LazyVim/LazyVim/discussions/104
      local navic = table.remove(opts.sections.lualine_c)
      opts.winbar = { lualine_c = { navic } }
      --#endregion
    end,
  },
}
