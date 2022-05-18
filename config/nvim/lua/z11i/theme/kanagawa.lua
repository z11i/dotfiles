local default_colors = require("kanagawa.colors").setup()
require('kanagawa').setup({
    undercurl = true,           -- enable undercurls
    commentStyle = "NONE",
    functionStyle = "NONE",
    keywordStyle = "bold",
    statementStyle = "bold",
    typeStyle = "NONE",
    variablebuiltinStyle = "NONE",
    specialReturn = true,       -- special highlight for the return keyword
    specialException = true,    -- special highlight for exception handling keywords
    transparent = true,        -- do not set background color
    colors = {},
    overrides = {
        GitSignsAddLnInline = { fg = "NONE", bg = "#1D572C", style="NONE", guisp="blue" },
        GitSignsChangeLnInline = { fg = "NONE", bg = "#686b44", style="NONE", guisp="blue" },
        GitSignsDeleteLnInline = { fg = "NONE", bg = "#803030", style="NONE", guisp="blue" },
    },
})
vim.cmd("colorscheme kanagawa")
