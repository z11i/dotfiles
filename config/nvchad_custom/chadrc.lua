local M = {}

M.plugins = require("custom.plugins")

M.ui = {
  theme = "decay",
  theme_toggle = { "decay", "one_light" }
}

M.mappings = require("custom.mappings")

M.commands = require("custom.commands")

return M
