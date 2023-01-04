local tnok, tokyonight = pcall(require, 'tokyonight')

if tnok then
	tokyonight.setup({
		dim_inactive = true,
		lualine_bold = true,
		sidebars = {"qf", "neo-tree"},
		day_brightness = 0.1,
    	on_highlights = function(hl, c)
    		-- make telescope borderless
        	local prompt = "#2d3149"
        	hl.TelescopeNormal = {
          		bg = c.bg_dark,
          		fg = c.fg_dark,
        	}
        	hl.TelescopeBorder = {
          		bg = c.bg_dark,
          		fg = c.bg_dark,
        	}
        	hl.TelescopePromptNormal = {
          		bg = prompt,
        	}
        	hl.TelescopePromptBorder = {
          		bg = prompt,
          		fg = prompt,
        	}
        	hl.TelescopePromptTitle = {
          		bg = prompt,
          		fg = prompt,
        	}
        	hl.TelescopePreviewTitle = {
          		bg = c.bg_dark,
          		fg = c.bg_dark,
        	}
        	hl.TelescopeResultsTitle = {
          		bg = c.bg_dark,
          		fg = c.bg_dark,
        	}
        	-- git word diffs
        	hl.GitSignsAddLnInline = {bg = "#1c4428"}
            hl.GitSignsChangeLnInline = {bg = "#1e4173"}
            hl.GitSignsDeleteLnInline = {bg = "#542426", fg = "#2c314a"}
    	end,
	})
end

local dnok, dark_notify = pcall(require, 'dark_notify')
if dnok then
	dark_notify.run({
    	schemes = {
        	dark = 'tokyonight-night',
        	light = 'tokyonight-day',
    	}
	})
end
