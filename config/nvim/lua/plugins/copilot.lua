return {
  {
    "github/copilot.vim",
    enabled = false,
    build = "<cmd>Copilot setup",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.keymap.set("i", "<C-\\>", 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false })
    end,
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({})
    end,
    cmd = {
      "SupermavenStart",
      "SupermavenStop",
      "SupermavenRestart",
      "SupermavenToggle",
      "SupermavenStatus",
      "SupermavenUseFree",
      "SupermavenUsePro",
      "SupermavenLogout",
      "SupermavenShowLog",
      "SupermavenClearLog",
    },
  },
}
