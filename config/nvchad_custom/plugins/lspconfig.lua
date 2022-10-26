local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"
local servers = {
  --[[ "pyright", ]] "pylsp", "gopls", "html", "cssls", "jsonls"
}

local find_cmd = require("custom.utils").find_cmd

local custom_pyright = function(server, _on_attach, _capabilities)
  lspconfig[server].setup {
    on_attach = _on_attach,
    capabilities = _capabilities,
    before_init = function(_, config)
      local p
      if vim.env.VIRTUAL_ENV then
        p = lspconfig.util.path.join(vim.env.VIRTUAL_ENV, "bin", "python3")
      else
        p = find_cmd("python3", ".venv/bin", config.root_dir)
      end
      config.settings.python.pythonPath = p
    end
  }
end

for _, lsp in ipairs(servers) do
  if lsp == "pyright" then
    custom_pyright(lsp, on_attach, capabilities)
  else
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
end
