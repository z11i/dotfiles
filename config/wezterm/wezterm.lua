local wezterm = require("wezterm")

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "GitHub Dark",
			{
				window_frame = {
					active_titlebar_bg = "#333333",
					inactive_titlebar_bg = "#333333",
				},
			}
	else
		return "iceberg-light",
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

local act = wezterm.action
local keys = {
	{ key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "s", mods = "CTRL|SHIFT", action = act.PaneSelect({ mode = "SwapWithActive" }) },
	{ key = "{", mods = "CTRL|SHIFT", action = act.RotatePanes("CounterClockwise") },
	{ key = "}", mods = "CTRL|SHIFT", action = act.RotatePanes("Clockwise") },
}

return {
	bold_brightens_ansi_colors = false,
	enable_scroll_bar = true,
	font = wezterm.font("Berkeley Mono Variable"),
	font_size = 15.8,
	front_end = "WebGpu",
	keys = keys,
	line_height = 1.1,
	scrollback_lines = 10000,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 10,
	},
}
