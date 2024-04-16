return {
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    keys = {
      { "<C-h>", '<cmd>lua require("smart-splits").move_cursor_left() <cr>', desc = "Move Left" },
      { "<C-j>", '<cmd>lua require("smart-splits").move_cursor_down() <cr>', desc = "Move Down" },
      { "<C-k>", '<cmd>lua require("smart-splits").move_cursor_up() <cr>', desc = "Move Up" },
      { "<C-l>", '<cmd>lua require("smart-splits").move_cursor_right() <cr>', desc = "Move Right" },

      { "<C-S-h>", '<cmd>lua require("smart-splits").resize_left() <cr>', desc = "Resize Left" },
      { "<C-S-j>", '<cmd>lua require("smart-splits").resize_down() <cr>', desc = "Resize Down" },
      { "<C-S-k>", '<cmd>lua require("smart-splits").resize_up() <cr>', desc = "Resize Up" },
      { "<C-S-l>", '<cmd>lua require("smart-splits").resize_right() <cr>', desc = "Resize Right" },
    },
  },
}
