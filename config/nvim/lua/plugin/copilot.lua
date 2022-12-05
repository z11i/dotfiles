local map = require('util').map
map('i', '<C-space>', 'copilot#Accept("<CR>")', {expr = true})
vim.g.copilot_no_tab_map = true
