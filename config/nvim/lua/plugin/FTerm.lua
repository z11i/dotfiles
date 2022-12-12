local map = require('util').map
map('n', '<A-t>', '<cmd>lua require("FTerm").toggle()<CR>')
map('t', '<A-t>', '<C-\\><C-n><cmd>lua require("FTerm").toggle()<CR>')
map('i', '<A-t>', '<esc><cmd>lua require("FTerm").toggle()<CR>')
