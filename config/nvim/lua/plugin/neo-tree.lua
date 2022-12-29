local map = require('util').map
map('n', '<F3>', ':NeoTreeRevealToggle<cr>')
require("neo-tree").setup({
    sort_case_insensitive = true,
    filesystem = {
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignore = false,
            never_show = {
                ".DS_Store",
            },
        },
        follow_current_file = true,
        group_empty_dirs = true,
        hijack_netrw_behavior = "open_current",
    }
})
