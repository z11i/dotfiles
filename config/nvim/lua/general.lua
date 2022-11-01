local o = vim.o -- global options
local wo = vim.wo -- window local options
local bo = vim.bo -- buffer local options

-- File auto-read.
o.autoread = true

-- Indentation.
o.autoindent = true
o.copyindent = true
o.preserveindent = true
o.breakindent = true
o.expandtab = false
o.tabstop = 4
o.shiftwidth = 4

---- Invisible characters.
--o.list = true
--o.listchars = "tab:> ,lead:·,trail:·,extends:⇢,precedes:⇠,nbsp:+"

-- Formatting.
o.formatoptions = o.formatoptions..'tcjnp'

-- Line numbers.
o.number = true
o.relativenumber = true

-- Command line.
o.confirm = true

-- Wildmenu.
o.wildmenu = true
o.wildignorecase = true

-- Status line.
o.laststatus = 3 -- global status line

-- Search.
o.hlsearch = true
o.incsearch = true
o.smartcase = true

-- Swap j and gj, k and gk to handle wrapped lines
local map = require("util").map
map("n", "j", "gj")
map("n", "gj", "j")
map("n", "k", "gk")
map("n", "gk", "k")
