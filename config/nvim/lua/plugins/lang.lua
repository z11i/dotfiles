return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint_d",
        "gopls",
        "luacheck",
        "prettierd",
        "rust-analyzer",
        "stylua",
        "shellcheck",
        "shfmt",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    version = false,
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        bashls = {},
        clangd = {},
        cssls = {},
        dockerls = {},
        gopls = {},
        -- pylsp = {
        --   settings = {
        --     pylsp = {
        --       plugins = {
        --         pycodestyle = {
        --           enabled = false,
        --           ignore = { "E111", "E114", "E121" },
        --           maxLineLength = 120,
        --         },
        --         flake8 = { enabled = false },
        --         pylint = { enabled = false },
        --         pyflakes = { enabled = false },
        --         autopep8 = { enabled = false },
        --         yapf = { enabled = false },
        --         ruff = { enabled = true },
        --       },
        --     },
        --   },
        -- },
        jsonls = {},
        lua_ls = {},
        pyright = {
          settings = {
            python = {
              analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        rust_analyzer = {},
        svelte = {},
        tsserver = {},
        yamlls = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy", -- navbuddy needs to load before lsp
        config = function()
          local navbuddy = require("nvim-navbuddy")
          navbuddy.setup({
            lsp = { auto_attach = true },
          })
        end,
        dependencies = {
          "neovim/nvim-lspconfig",
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        keys = {
          { "<leader>n", "<cmd>lua require('nvim-navbuddy').open()<cr>", desc = "Open navbuddy" },
        },
        cmd = { "Navbuddy" },
      },
    },
  },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.json" },
  {
    "github/copilot.vim",
    build = "<cmd>Copilot setup",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.keymap.set("i", "<C-\\>", 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false })
    end,
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "NMAC427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup()
    end,
    event = "BufReadPre",
  },
}
