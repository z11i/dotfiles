local wezterm = require("wezterm")

--#region Colors
local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		-- return "Catppuccin Mocha",
		return "Ayu Dark (Gogh)",
			{
				window_frame = {
					active_titlebar_bg = "#333333",
					inactive_titlebar_bg = "#333333",
				},
			}
	else
		return "Catppuccin Latte",
		-- return "Everforest Light Hard (Gogh)",
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

	-- Run theme switch in background to avoid blocking WezTerm UI
	wezterm.background_child_process({ "/usr/local/bin/switch-theme", string.lower(appearance) })

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
		font_size = 17 -- MacBook retina display (HiDPI)
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

-- Toggle floating pane functionality
-- Simple base64 encoder
local function base64_encode(data)
	local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	return ((data:gsub(".", function(x)
		local r, b = "", x:byte()
		for i = 8, 1, -1 do
			r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0")
		end
		return r
	end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
		if #x < 6 then
			return ""
		end
		local c = 0
		for i = 1, 6 do
			c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
		end
		return b:sub(c + 1, c + 1)
	end) .. ({ "", "==", "=" })[#data % 3 + 1])
end

local function find_pane_by_program(tab, program_name)
	wezterm.log_info("Looking for program: " .. program_name)
	for _, p in ipairs(tab:panes()) do
		local user_vars = p:get_user_vars()
		wezterm.log_info("Pane " .. p:pane_id() .. " user_vars: " .. wezterm.json_encode(user_vars))
		if user_vars.wezterm_prog == program_name then
			wezterm.log_info("Match found via user var!")
			return p
		end
		-- Fallback: check foreground process
		local process_info = p:get_foreground_process_info()
		if process_info then
			wezterm.log_info("Pane " .. p:pane_id() .. " process: " .. tostring(process_info.name))
			if process_info.name == program_name then
				wezterm.log_info("Match found via process name!")
				return p
			end
		end
	end
	wezterm.log_info("No match found")
	return nil
end

local function toggle_program(program_name, program_cmd)
	return wezterm.action_callback(function(window, pane)
		local tab = window:active_tab()
		local existing_pane = find_pane_by_program(tab, program_name)

		-- If we're currently in the program pane, close it
		if existing_pane and pane:pane_id() == existing_pane:pane_id() then
			wezterm.log_info("In program pane, closing it")
			window:perform_action(action.CloseCurrentPane({ confirm = false }), existing_pane)
			return
		end

		-- If program pane exists but we're not in it, activate and zoom it
		if existing_pane then
			wezterm.log_info("Switching to existing program pane and zooming")
			existing_pane:activate()
			tab:set_zoomed(true)
			return
		end

		-- Program pane doesn't exist, create it
		wezterm.log_info("Creating new pane for: " .. program_name)
		local cwd = pane:get_current_working_dir()
		local encoded_name = base64_encode(program_name)
		wezterm.log_info("Base64 encoded name: " .. encoded_name)
		local wrapped_cmd = string.format(
			'printf "\\033]1337;SetUserVar=wezterm_prog=%s\\007"; %s',
			encoded_name,
			program_cmd
		)
		wezterm.log_info("Running command: " .. wrapped_cmd)
		pane:split({
			direction = "Right",
			size = 0.4,
			args = { os.getenv("SHELL"), "-l", "-c", wrapped_cmd },
			cwd = cwd,
		})
		-- Note: newly created pane is automatically activated, zoom it
		tab:set_zoomed(true)
		wezterm.log_info("Created and zoomed new pane")
	end)
end

-- Floating pane keybindings (yazi, lazygit, claude code, scrollback capture)
assign_key({ "CMD" }, "y", toggle_program("yazi", "yazi"))
assign_key({ "CMD" }, "g", toggle_program("lazygit", "lazygit"))
assign_key({ "CMD" }, "d", toggle_program("claude", "claude"))

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
	line_height = 1.3,
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
