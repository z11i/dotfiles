local map = require("util").map
local g = vim.g -- global variables
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
o.ignorecase = true
o.smartcase = true

-- Swap j and gj, k and gk to handle wrapped lines.
map("n", "j", "gj")
map("n", "gj", "j")
map("n", "k", "gk")
map("n", "gk", "k")

-- Leader.
g.mapleader = " "

-- Buffer.
map("n", "<tab>", ":bnext<cr>")
map("n", "<s-tab>", ":bprevious<cr>")
map("i", "<C-tab>", "<C-o>:bnext<cr>")
map("i", "<C-s-tab>", "<C-o>:bprevious<cr>")

-- Splits.
map("n", "<A-h>", "<C-w>h")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")
map("n", "<C-tab>", "<C-w>w")
