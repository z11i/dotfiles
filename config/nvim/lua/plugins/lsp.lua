return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- lua
        -- "luacheck",
        "stylua",
        -- shell
        "shellcheck",
        "shfmt",
        -- python
        -- "black",
        "isort",
        "mypy",
        "ruff",
        "ruff-lsp",
        -- go
        "gofumpt",
        "golines",
        "gopls",
        -- rust
        "rust-analyzer",
        -- web
        "eslint_d",
        "prettierd",
      },
      PATH = "append",
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      -- [[
      -- -- use this in .exrc to set local formatters
      -- local conform = require"conform"
      -- conform.formatters_by_ft.go = vim.tbl_filter(function(f) return f ~= "gofumpt" end, conform.formatters_by_ft.go)
      -- ]]
      ---@type table<string, conform.FormatterUnit[]>
      formatters_by_ft = {
        go = { "gofumpt", "golines" },
        python = { "ruff" },
      },
      formatters = {
        golines = {
          command = "golines",
          prepend_args = { "-m", "128" },
        },
      },
    },
    keys = {
      {
        "<leader>ucg",
        function()
          local ok, cf = pcall(require, "conform")
          if not ok then
            return
          end
          local formatters = cf.formatters_by_ft.go
          if not formatters then
            cf.formatters_by_ft.go = { "golines" }
            vim.notify("golines is enabled", vim.log.levels.INFO)
            return
          end
          -- iterate over formatters, if golines is present, remove it, if not add it
          local found = false
          local index = nil
          assert(type(formatters) == "table")
          for i, v in ipairs(formatters) do
            if v == "golines" then
              found = true
              index = i
              break
            end
          end
          if found then
            table.remove(cf.formatters_by_ft.go, index)
            vim.notify("golines is disabled", vim.log.levels.INFO)
          else
            table.insert(cf.formatters_by_ft.go, "golines")
            vim.notify("golines is enabled", vim.log.levels.INFO)
          end
        end,
        desc = "Toggle Conform - golines",
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    enabled = false,
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          -- lua
          -- nls.builtins.diagnostics.luacheck, -- not needed with luals and lazyvim
          nls.builtins.formatting.stylua,
          -- shell
          nls.builtins.code_actions.shellcheck,
          nls.builtins.diagnostics.fish,
          nls.builtins.formatting.fish_indent,
          nls.builtins.formatting.shfmt,
          -- python
          nls.builtins.diagnostics.mypy,
          nls.builtins.diagnostics.ruff,
          nls.builtins.formatting.black,
          nls.builtins.formatting.isort,
          -- go
          nls.builtins.formatting.gofumpt,
          -- rust
          nls.builtins.formatting.rustfmt,
          -- web
          nls.builtins.code_actions.eslint_d,
          nls.builtins.formatting.prettierd,
          nls.builtins.formatting.rome,
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
        rust_analyzer = function(_, opts)
          require("rust-tools").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
      inlay_hints = { enabled = true },
    },
    dependencies = {
      { "SmiteshP/nvim-navbuddy" }, -- navbuddy needs to load before lsp
      -- { -- TODO this is a hacky plugin, wait for https://github.com/neovim/neovim/pull/9496
      --   "simrat39/inlay-hints.nvim",
      --   config = function()
      --     require("inlay-hints").setup()
      --   end,
      -- },
      { "simrat39/rust-tools.nvim" },
    },
  },
  {
    "NMAC427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup()
    end,
    event = "BufReadPre",
  },
}
