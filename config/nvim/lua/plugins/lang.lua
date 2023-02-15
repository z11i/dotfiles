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
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        bashls = {},
        clangd = {},
        cssls = {},
        dockerls = {},
        jsonls = {},
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
        sumneko_lua = {},
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
    event = "BufReadPre",
  },
  {
    "NMAC427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup()
    end,
    event = "BufReadPre",
  },
}
