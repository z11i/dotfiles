local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)
require("lazy").setup({
	{'MunifTanjim/exrc.nvim', config = function() require('exrc').setup() end},
	-- UI stuff
    {
  	    'nvim-telescope/telescope.nvim', tag = '0.1.0',
  	    config = function() require("plugin/telescope") end,
  	    dependencies = {
  	        {'nvim-lua/plenary.nvim'},
  	        {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  	    }
    },
    { "folke/which-key.nvim", config=function() require("plugin/which-key") end },
    {
        "nvim-neo-tree/neo-tree.nvim", branch = "v2.x", config=function() require("plugin/neo-tree") end,
        keys = { "<F3>" },
        cmd = { "NeoTreeToggle", "NeoTreeFloat", "NeoTreeFloatToggle",
        "NeoTreeRevealToggle", "NeoTreeShowToggle" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    },

    -- jump around in buffers
    {'ggandor/leap.nvim', config = function() require("plugin/leap") end, lazy = true, keys = { "f", "F", "t", "T", "\\" }},
    {'ggandor/flit.nvim', lazy = true},
	-- theme
    'folke/tokyonight.nvim',

    -- language support
    {'nvim-treesitter/nvim-treesitter', config = function() require("plugin/treesitter") end, lazy = true,
        dependencies = 'nvim-treesitter/nvim-treesitter-textobjects'},
    {'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle'}, -- Debug tree-sitter
    -- Show code context (show function if scrolled beyond screen)
    {'lewis6991/nvim-treesitter-context', lazy = true},
    {
        'github/copilot.vim', build = ':Copilot setup', config=function() require("plugin.copilot") end,
        event = 'VeryLazy'
    },
    {
  	    'VonHeikemen/lsp-zero.nvim', config=function() require("plugin/lsp-zero") end,
  	    event = 'VeryLazy',
  	    dependencies = {
            -- LSP Support
    	    {'neovim/nvim-lspconfig'},
    	    {'williamboman/mason.nvim'},
    	    {'williamboman/mason-lspconfig.nvim'},

    	    -- Autocompletion
    	    {'hrsh7th/nvim-cmp'},
    	    {'hrsh7th/cmp-buffer'},
    	    {'hrsh7th/cmp-path'},
    	    {'saadparwaiz1/cmp_luasnip'},
    	    {'hrsh7th/cmp-nvim-lsp'},
    	    {'hrsh7th/cmp-nvim-lua'},

    	    -- Snippets
    	    {'L3MON4D3/LuaSnip'},
    	    {'rafamadriz/friendly-snippets'},
  	    }
    },
    {
        "cshuaimin/ssr.nvim",
        -- init is always executed during startup, but doesn't load the plugin yet.
        -- init implies lazy loading
        init = function()
            vim.keymap.set({ "n", "x" }, "<leader>sr", function()
                -- this require will automatically load the plugin
                require("ssr").open()
            end, { desc = "Structural Replace" })
        end,
    },
    {
        "NMAC427/guess-indent.nvim", config = function() require('guess-indent').setup {} end,
    }, -- guess the buffer indent and set relevant vim options
    -- show indent guides
    {"lukas-reineke/indent-blankline.nvim", config=function() require("plugin/indent-blankline") end, event = 'VeryLazy'},
    { 'lewis6991/gitsigns.nvim', tag = 'release', config = function() require("plugin/gitsigns") end, event = 'VeryLazy'},
    { 'numToStr/FTerm.nvim', config = function() require("plugin/FTerm") end, keys = {"<A-t>"}},
    'cormacrelf/dark-notify', -- macOS dark mode switch hook
    { 'kevinhwang91/nvim-bqf', ft = 'qf', dependencies = {'junegunn/fzf', build = function() vim.fn['fzf#install']() end } },
    { 'nvim-lualine/lualine.nvim', config = function() require("plugin/lualine") end },
    {'windwp/nvim-autopairs', config = function() require("plugin/autopairs") end, event = 'VeryLazy'}, -- auto close brackets
    {'numToStr/Comment.nvim', config = function () require('Comment').setup() end, event = 'VeryLazy'}, -- comments
    {'tpope/vim-surround', event = 'VeryLazy'}, -- surround text objects
    {'b0o/incline.nvim', config = function() require('incline').setup({hide = {cursorline = true}}) end, event = 'VeryLazy' }, -- show file names for buffers when using laststatus=3
})

