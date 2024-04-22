return {
  "letieu/wezterm-move.nvim",
  keys = {
    {
      "<C-S-Left>",
      function()
        require("wezterm-move").move("h")
      end,
    },
    {
      "<C-S-Down>",
      function()
        require("wezterm-move").move("j")
      end,
    },
    {
      "<C-S-Up>",
      function()
        require("wezterm-move").move("k")
      end,
    },
    {
      "<C-S-Right>",
      function()
        require("wezterm-move").move("l")
      end,
    },
    -- {
    --   "<C-;>",
    --   function()
    --     require("wezterm-move").move("j")
    --   end,
    -- },
  },
}
