local M = {}

M.disabled = {
  n = {
    -- general 
    ["<leader>n"] = "",
    ["<leader>rn"] = "",

    -- telescope
    ["<leader>cm"] = "",
  },
}

M.telescope = {
  n = {
    ["<leader>gm"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    ["<leader>ts"] = { "<cmd> Telescope <CR>", "open telescope"}
  }
}

return M
