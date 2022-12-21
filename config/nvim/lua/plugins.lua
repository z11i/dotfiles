local ensure_packer = function()
    local fn = vim.fn
  	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  	if fn.empty(fn.glob(install_path)) > 0 then
    	fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    	vim.cmd [[packadd packer.nvim]]
    	return true
  	end
  	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  	use 'wbthomason/packer.nvim'
  	use {'MunifTanjim/exrc.nvim', config = function() require('exrc').setup() end}
  	use {'nvim-treesitter/nvim-treesitter', config = function() require("plugin/treesitter") end}
  	use {'ggandor/leap.nvim', config = function() require("plugin/leap") end}
  	use {
  	  	'nvim-telescope/telescope.nvim', tag = '0.1.0',
  	    config = function() require("plugin/telescope") end,
  	  	requires = {
  	  	  	{'nvim-lua/plenary.nvim'},
  	  	  	{'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  	  	}
  	}
	-- theme
  	--use {'nyoom-engineering/oxocarbon.nvim', config = function() require("plugin/oxocarbon") end}
  	use {'folke/tokyonight.nvim', config = function() require("plugin/tokyonight") end}

  	use {'github/copilot.vim', run = ':Copilot setup', config=function() require("plugin.copilot") end}
  	use {
  	  	'VonHeikemen/lsp-zero.nvim', config=function() require("plugin/lsp-zero") end,
  	  	requires = {
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
  	}
  	use { -- structural search and replace
  		"cshuaimin/ssr.nvim", module = "ssr", config=function() require("plugin/ssr") end
	}
	use {
		"folke/which-key.nvim", config=function() require("plugin/which-key") end
	}
	use {
  		"nvim-neo-tree/neo-tree.nvim", branch = "v2.x", config=function() require("plugin/neo-tree") end,
    	requires = {
      		"nvim-lua/plenary.nvim",
      		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      		"MunifTanjim/nui.nvim",
    	}
  	}
  	use { -- guess the buffer indent and set relevant vim options
  		"NMAC427/guess-indent.nvim", config = function() require('guess-indent').setup {} end,
	}
	-- show indent guides
	use {"lukas-reineke/indent-blankline.nvim", config=function() require("plugin/indent-blankline") end}
	use { 'lewis6991/gitsigns.nvim', tag = 'release', config = function() require("plugin/gitsigns") end }
	-- switch between vim splits and kitty windows seamllessly
	use { 'knubie/vim-kitty-navigator', run = 'cp ./*.py ~/.config/kitty/', config = function() require("plugin/kitty-navigator") end }
  	use { 'numToStr/FTerm.nvim', config = function() require("plugin/FTerm") end }
	--use { 'feline-nvim/feline.nvim', config = function() require("plugin/feline") end }
    use { 'cormacrelf/dark-notify', config = function() require("plugin/dark-notify") end } -- macOS dark mode switch hook
    use { 'kevinhwang91/nvim-bqf', ft = 'qf', requires = {'junegunn/fzf', run = function() vim.fn['fzf#install']() end } }
    use { 'nvim-lualine/lualine.nvim', config = function() require("plugin/lualine") end }
    use {'windwp/nvim-autopairs', config = function() require("plugin/autopairs") end} -- auto close brackets

  	-- Automatically set up your configuration after cloning packer.nvim
  	-- Put this at the end after all plugins
  	if packer_bootstrap then
    	require('packer').sync()
  	end
end)
