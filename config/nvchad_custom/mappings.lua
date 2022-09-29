local M = {}

------------------------------------------- default plugins ------------------------------------------- 

M.disabled = {
  n = {
    -- line numbers
    ["<leader>n"] = "",
    ["<leader>rn"] = "",
    -- switch between windows
    ["<C-h>"] = "",
    ["<C-l>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",
    -- save
    ["<C-s>"] = "",

    -- Copy all
    ["<C-c>"] = "",

    -- telescope
    ["<leader>cm"] = "",

    -- buffer
    ["<leader>b"] = "",
    -- pick buffers via numbers
    ["<Bslash>"] = "",

    -- nvterm
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
    ["<leader>h"] = "",
    ["<leader>v"] = "",

    -- comment
    ["<leader>/"] = "",
    -- theme
    ["<leader>tt"] = "",
    ["<leader>th"] = "",
  },

  v = {
    ["<leader>/"] = "",
  },

  t = {
    -- nvterm
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
  },
}

M.buffer = {
  n = {
    ["C-x"] = { "<cmd> bdelete <cr>", "close buffer" },
    -- pick buffers via numbers
    ["<C-~>"] = { "<cmd> TbufPick <CR>", "Pick buffer" },
  },
  i = {
    ["<A-s>"] = { "<esc><cmd> w <cr>", "save file" },
  },
}

M.comment = {
  i = {
    ["<C-/>"] = { "<ESC><cmd>lua require('Comment.api').toggle.linewise.current()<CR>i", "toggle comment" },
  },
  n = {
    ["<C-/>"] = { function() require("Comment.api").toggle.linewise.current() end, "toggle comment" },
  },

  v = {
    ["<C-/>"] = { "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "toggle comment" },
  },
}

M.telescope = {
  n = {
    ["<leader>gm"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    ["<leader>ts"] = { "<cmd> Telescope <CR>", "open telescope"}
  }
}

M.theme = {
  n = {
    ["<leader>Th"] = { "<cmd> Telescope themes <CR>", "nvchad themes" },
    ["<leader>Tt"] = { function() require("base46").toggle_theme() end, "toggle theme" },
  },
}

M.nvterm = {
  t = {
    -- toggle in terminal mode
    ["<A-t><A-t>"] = { function() require("nvterm.terminal").toggle "float" end, "toggle floating term" },

    ["<A-t><A-h>"] = { function() require("nvterm.terminal").toggle "horizontal" end, "toggle horizontal term" },

    ["<A-t><A-v>"] = { function() require("nvterm.terminal").toggle "vertical" end, "toggle vertical term" },
  },

  n = {
    -- toggle in normal mode
    ["<A-t><A-t>"] = { function() require("nvterm.terminal").toggle "float" end, "toggle floating term" },

    ["<A-t><A-h>"] = { function() require("nvterm.terminal").toggle "horizontal" end, "toggle horizontal term" },

    ["<A-t><A-v>"] = { function() require("nvterm.terminal").toggle "vertical" end, "toggle vertical term" },

    -- new

    ["<leader>th"] = { function() require("nvterm.terminal").new "horizontal" end, "new horizontal term" },

    ["<leader>tv"] = { function() require("nvterm.terminal").new "vertical" end, "new vertical term" },
  },
}

------------------------------------------- custom plugins ------------------------------------------- 

return M
