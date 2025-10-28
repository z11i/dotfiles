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

	-- Adjust font size based on screen resolution
	local screens = wezterm.gui and wezterm.gui.screens() or { active = {} }
	local screen = screens.active or {}
	local screen_width = screen.width or 0
	local screen_height = screen.height or 0
	local screen_scale = screen.scale or 1.0

	local font_size = 16 -- default
	if screen_scale <= 1.0 and (screen_width >= 3840 or screen_height >= 2160) then
		font_size = 18 -- 4K external display
	elseif screen_scale >= 2.0 then
		font_size = 15 -- MacBook retina display (HiDPI)
	end

	if overrides.font_size ~= font_size then
		overrides.font_size = font_size
		window:set_config_overrides(overrides)
	end
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

-- Floating pane keybindings (yazi, lazygit, scrollback capture)
assign_key({ "CMD" }, "y", wezterm.action_callback(function(window, pane)
	local cwd = pane:get_current_working_dir()
	pane:split({
		direction = "Right",
		size = 0.95,
		args = { os.getenv("SHELL"), "-l", "-c", "yazi" },
		cwd = cwd,
	})
end))

assign_key({ "CMD" }, "g", wezterm.action_callback(function(window, pane)
	local cwd = pane:get_current_working_dir()
	pane:split({
		direction = "Right",
		size = 0.95,
		args = { os.getenv("SHELL"), "-l", "-c", "lazygit" },
		cwd = cwd,
	})
end))

assign_key({ "CMD" }, "e", wezterm.action_callback(function(window, pane)
	local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)
	local temp_file = os.tmpname()
	local file = io.open(temp_file, "w")
	if file then
		file:write(text)
		file:close()
		pane:split({
			direction = "Right",
			size = 0.95,
			args = { os.getenv("SHELL"), "-l", "-c", "hx " .. temp_file },
		})
	end
end))
--#endregion

return {
	animation_fps = 60,
	bold_brightens_ansi_colors = true,
	enable_scroll_bar = true,
	font = wezterm.font_with_fallback({ "Berkeley Mono SemiCondensed", "Berkeley Mono", "PingFang SC" }),
	keys = keys,
	line_height = 1.2,
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
