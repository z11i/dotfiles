return {
  { "kevinhwang91/nvim-bqf", ft = "qf", dependencies = { "junegunn/fzf" } },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.sections.lualine_b = {}
    end,
  },
}
