return {
  {
    "simrat39/rust-tools.nvim",
    cond = not vim.g.vscode,
    keys = { { "<F5>rr", "<cmd>RustRunnables<cr>", desc = "RustRunnables" } },
  },
  -- {
  --   -- LuaSnip has been hanging when fetching.
  --   -- https://github.com/L3MON4D3/LuaSnip/issues/1071
  --   "L3MON4D3/LuaSnip",
  --   version = "v2.*",
  --   build = "make install_jsregexp",
  -- },
}
