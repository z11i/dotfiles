return {
  {
    "rafcamlet/nvim-luapad",
    cmd = { "Luapad", "LuaRun" },
  },
  {
    "willothy/flatten.nvim",
    config = true,
    -- or pass configuration with
    -- opts = {  }
    lazy = false,
    priority = 1001,
  },
  {
    "tris203/hawtkeys.nvim",
    enabled = false, -- dvorak is not yet supported: https://github.com/tris203/hawtkeys.nvim/issues/45
    opts = {
      keyboardLayout = "dvorak",
    },
    cmd = { "Hawtkeys", "HawtkeysAll", "HawtkeysDupes" },
  },
}
