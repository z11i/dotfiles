return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- lua
        "luacheck",
        "stylua",
        -- shell
        "shellcheck",
        "shfmt",
        -- python
        "isort",
        "black",
        "mypy",
        -- go
        "gopls",
        "gofumpt",
        -- rust
        "rust-analyzer",
        "rustfmt",
        -- web
        "prettierd",
        "eslint_d",
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          -- lua
          nls.builtins.formatting.stylua,
          -- shell
          nls.builtins.formatting.fish_indent,
          nls.builtins.diagnostics.fish,
          nls.builtins.code_actions.shellcheck,
          nls.builtins.formatting.shfmt,
          -- python
          nls.builtins.formatting.isort,
          nls.builtins.formatting.black,
          nls.builtins.diagnostics.mypy,
          -- go
          nls.builtins.formatting.gofumpt,
          -- rust
          nls.builtins.formatting.rustfmt,
          -- web
          nls.builtins.formatting.prettierd,
          nls.builtins.code_actions.eslint_d,
        },
      }
    end,
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
      { "SmiteshP/nvim-navbuddy" }, -- navbuddy needs to load before lsp
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
