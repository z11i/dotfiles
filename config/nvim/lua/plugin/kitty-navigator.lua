vim.cmd [[let g:kitty_navigator_no_mappings = 1]]
local map = require('util').map
map('n', '<A-h>', '<cmd>KittyNavigateLeft<CR>')
map('n', '<A-j>', '<cmd>KittyNavigateDown<CR>')
map('n', '<A-k>', '<cmd>KittyNavigateUp<CR>')
map('n', '<A-l>', '<cmd>KittyNavigateRight<CR>')
