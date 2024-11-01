return {
  {
    "rafcamlet/nvim-luapad",
    cond = not vim.g.vscode,
    cmd = { "Luapad", "LuaRun" },
  },
  {
    "willothy/flatten.nvim",
    cond = not vim.g.vscode,
    config = true,
    -- or pass configuration with
    -- opts = {  }
    lazy = false,
    priority = 1001,
  },
  {
    "tris203/hawtkeys.nvim",
    cond = not vim.g.vscode,
    enabled = false, -- dvorak is not yet supported: https://github.com/tris203/hawtkeys.nvim/issues/45
    opts = {
      keyboardLayout = "dvorak",
    },
    cmd = { "Hawtkeys", "HawtkeysAll", "HawtkeysDupes" },
  },
}
