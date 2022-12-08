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
  	use {'B4mbus/oxocarbon-lua.nvim', config = function() require("plugin/oxocarbon") end}

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

  	-- Automatically set up your configuration after cloning packer.nvim
  	-- Put this at the end after all plugins
  	if packer_bootstrap then
    	require('packer').sync()
  	end
end)
