local wezterm = require("wezterm")

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		-- return "Catppuccin Mocha",
		return "tokyonight",
			{
				window_frame = {
					active_titlebar_bg = "#333333",
					inactive_titlebar_bg = "#333333",
				},
			}
	else
		-- return "Catppuccin Latte",
		return "tokyonight-day",
			{
				window_frame = {
					active_titlebar_bg = "#eeeeee",
					inactive_titlebar_bg = "#eeeeee",
				},
			}
	end
end

wezterm.on("window-config-reloaded", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local appearance, ext_configs = window:get_appearance() -- TODO: merge ext_configs
	local scheme = scheme_for_appearance(appearance)
	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
	os.execute("/usr/local/bin/switch-theme " .. string.lower(appearance))
end)

local action = wezterm.action
local keys = {}
local function assign_key(modss, key, act)
	for _, v in ipairs(modss) do
		if act == nil then
			act = action.DisableDefaultAssignment
		end
		table.insert(keys, { key = key, mods = v, action = act })
	end
end
assign_key({ "CMD", "CTRL|SHIFT" }, "w", action.CloseCurrentPane({ confirm = true }))
assign_key({ "CMD", "CTRL|SHIFT" }, "s", action.PaneSelect({ alphabet = "1234567890" }))
assign_key({ "CTRL|SHIFT" }, "{", action.RotatePanes("CounterClockwise"))
assign_key({ "CTRL|SHIFT" }, "}", action.RotatePanes("Clockwise"))
assign_key({ "CMD", "CTRL|SHIFT" }, "f", action.Search({ CaseInSensitiveString = "" }))
assign_key({ "OPT" }, "Enter", nil) -- Opt+Enter is used by LazyVim for GitHub Copilot

return {
	animation_fps = 24,
	bold_brightens_ansi_colors = true,
	enable_scroll_bar = true,
	font = wezterm.font("Berkeley Mono Variable"),
	font_size = 15.4,
	freetype_load_target = "Light",
	front_end = "OpenGL",
	keys = keys,
	line_height = 1.1,
	scrollback_lines = 1048576,
	tab_max_width = 200,
	window_decorations = "INTEGRATED_BUTTONS|RESIZE",
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 10,
	},
}
