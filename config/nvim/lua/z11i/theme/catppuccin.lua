local colors = require("catppuccin.palettes").get_palette()

require("catppuccin").setup({
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    transparent_background = false,
    term_colors = false,
    compile = {
        enabled = true,
        path = vim.fn.stdpath "cache" .. "/catppuccin",
    },
    styles = {
        comments = {},
        conditionals = {},
        loops = {},
        functions = {},
        keywords = { "bold" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = { "bold" },
        operators = {},
    },
    integrations = {
        treesitter = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = {},
                hints = {},
                warnings = {},
                information = {},
            },
            underlines = {
                errors = {},
                hints = {},
                warnings = {},
                information = {},
            },
        },
        coc_nvim = false,
        lsp_trouble = true,
        cmp = true,
        lsp_saga = false,
        gitgutter = false,
        gitsigns = true,
        leap = false,
        telescope = true,
        nvimtree = {
            enabled = false,
            show_root = true,
            transparent_panel = false,
        },
        neotree = {
            enabled = true,
            show_root = true,
            transparent_panel = true,
        },
        dap = {
            enabled = true,
            enable_ui = true,
        },
        which_key = true,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
        },
        dashboard = false,
        neogit = false,
        vim_sneak = false,
        fern = false,
        barbar = false,
        bufferline = false,
        markdown = true,
        lightspeed = true,
        ts_rainbow = false,
        hop = false,
        notify = true,
        telekasten = false,
        symbols_outline = true,
        mini = false,
        aerial = false,
        vimwiki = false,
        beacon = false,
    },
    highlight_overrides = {
        mocha = {
            GitSignsAddLnInline = {bg = "#1c4428"},
            GitSignsChangeLnInline = {bg = "#1e4173"},
            GitSignsDeleteLnInline = {bg = "#542426", fg = "#2c314a"},
        },
        latte = {
            GitSignsAddLnInline = {bg = "#ccffd8"},
            GitSignsChangeLnInline = {bg = "#badfff"},
            GitSignsDeleteLnInline = {bg = "#ffd7d5"},
        }
    },
})

vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = function()
		vim.cmd("Catppuccin " .. (vim.v.option_new == "light" and "latte" or "mocha"))
	end,
})

vim.cmd("Catppuccin " .. (vim.o.background == "light" and "latte" or "mocha"))
if vim.fn.exists(':CccHighlighterEnable') then
    vim.cmd('CccHighlighterEnable')
end
