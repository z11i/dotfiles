require('gitsigns').setup({
    numhl = true,
    word_diff = false,
    current_line_blame = true,
    signs = {
        delete = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    },
    diff_opts = {
        algorithm = 'histogram',
        internal = true,
    },
    keymaps = {
        noremap = true,

        ['n ]h'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
        ['n [h'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

        ['n <C-g>g'] = ':Gitsigns ',
        ['n <C-g><C-s>h'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ['v <C-g><C-s>h'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        ['n <C-g><C-s>u'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ['n <C-g><C-s>b'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
        ['n <C-g><C-r>h'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ['v <C-g><C-r>h'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        ['n <C-g><C-r>b'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
        ['n <C-g><C-r>B'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',
        ['n <C-g><C-p>'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ['n <C-g><C-b>'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

        -- Text objects
        ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
        ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
    },
})
