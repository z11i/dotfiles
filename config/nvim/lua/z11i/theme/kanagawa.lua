local default_colors = require("kanagawa.colors").setup()
require('kanagawa').setup({
    undercurl = true,           -- enable undercurls
    commentStyle = {},
    functionStyle = {},
    keywordStyle = {bold = true},
    statementStyle = {bold = true},
    typeStyle = {},
    variablebuiltinStyle = {},
    specialReturn = true,       -- special highlight for the return keyword
    specialException = true,    -- special highlight for exception handling keywords
    transparent = true,        -- do not set background color
    colors = {},
    overrides = {
        GitSignsAddLnInline = { fg = "NONE", bg = "#1D572C" },
        GitSignsChangeLnInline = { fg = "NONE", bg = "#686b44" },
        GitSignsDeleteLnInline = { fg = "NONE", bg = "#803030" },
    },
})
vim.cmd("colorscheme kanagawa")
