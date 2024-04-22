local wezterm = require("wezterm")

--#region Colors
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
--#endregion

--#region Keys
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
assign_key({ "CTRL|META" }, "[", action.RotatePanes("CounterClockwise"))
assign_key({ "CTRL|META" }, "]", action.RotatePanes("Clockwise"))
assign_key({ "CMD", "CTRL|SHIFT" }, "f", action.Search({ CaseInSensitiveString = "" }))
assign_key({ "OPT" }, "Enter", nil) -- Opt+Enter is used by LazyVim for GitHub Copilot

local function is_vim(pane)
	local process_info = pane:get_foreground_process_info()
	local process_name = process_info and process_info.name

	return process_name == "nvim" or process_name == "vim"
end

local function find_vim_pane(tab)
	for _, pane in ipairs(tab:panes()) do
		if is_vim(pane) then
			return pane
		end
	end
end

local function split_nav(resize_or_move, key)
	local direction_keys = {
		LeftArrow = "Left",
		DownArrow = "Down",
		UpArrow = "Up",
		RightArrow = "Right",
	}
	return {
		{ resize_or_move == "resize" and "CTRL|META" or "CTRL|SHIFT" },
		key,
		wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "CTRL|META" or "CTRL|SHIFT" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

assign_key(table.unpack(split_nav("move", "UpArrow")))
assign_key(table.unpack(split_nav("move", "DownArrow")))
assign_key(table.unpack(split_nav("move", "LeftArrow")))
assign_key(table.unpack(split_nav("move", "RightArrow")))
assign_key(table.unpack(split_nav("resize", "UpArrow")))
assign_key(table.unpack(split_nav("resize", "DownArrow")))
assign_key(table.unpack(split_nav("resize", "LeftArrow")))
assign_key(table.unpack(split_nav("resize", "RightArrow")))
assign_key(
	{ "CTRL" },
	";",
	wezterm.action_callback(function(window, pane) -- toggle zoom
		local tab = window:active_tab()
		-- Open pane below if current pane is vim
		if is_vim(pane) then
			if (#tab:panes()) == 1 then
				-- Open pane below if when there is only one pane and it is vim
				pane:split({ direction = "Bottom" })
			else
				-- Send `CTRL-; to vim`, navigate to bottom pane from vim
				window:perform_action({
					SendKey = { key = ";", mods = "CTRL" },
				}, pane)
			end
			return
		end
		-- Zoom to vim pane if it exists
		local vim_pane = find_vim_pane(tab)
		if vim_pane then
			vim_pane:activate()
			tab:set_zoomed(true)
		end
	end)
)
--#endregion

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
