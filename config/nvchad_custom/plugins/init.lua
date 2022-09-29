local overrides = require "custom.plugins.overrides"

return {
  ------------------------------------------- default plugins ------------------------------------------- 
  ["goolord/alpha-nvim"] = {
    disable = false,
    cmd = "Alpha",
  },
  ["folke/which-key.nvim"] = {
    disable = false,
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["williamboman/mason.nvim"] = {
    override_options = overrides.mason
  },

  ------------------------------------------- custom plugins ------------------------------------------- 
  -- format & linting
   ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require "custom.plugins.null-ls"
      end,
 }
}
