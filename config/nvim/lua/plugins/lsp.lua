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
        gopls = function(_, opts)
          -- https://www.reddit.com/r/golang/comments/11xe63t
          local ih = require("inlay-hints")
          require("lazyvim.util").on_attach(function(client, bufnr)
            if client.name == "gopls" then
              ih.on_attach(client, bufnr)
              -- workaround to hl semanticTokens
              -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
              if not client.server_capabilities.semanticTokensProvider then
                local semantic = client.config.capabilities.textDocument.semanticTokens
                client.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers,
                  },
                  range = true,
                }
              end
            end
          end)
          opts.settings = {
            gopls = {
              semanticTokens = true,
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          }
        end,
        rust_analyzer = function(_, opts)
          require("rust-tools").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    dependencies = {
      { "SmiteshP/nvim-navbuddy" }, -- navbuddy needs to load before lsp
      { -- TODO this is a hacky plugin, wait for https://github.com/neovim/neovim/pull/9496
        "simrat39/inlay-hints.nvim",
        config = function()
          require("inlay-hints").setup()
        end,
      },
      { "simrat39/rust-tools.nvim" },
    },
  },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.json" },
  {
    "NMAC427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup()
    end,
    event = "BufReadPre",
  },
}
