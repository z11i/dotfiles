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
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = true },
      panel = { enabled = true },
    },
  },
}
