local present, tokyonight = pcall(require, 'tokyonight')

if present then
	tokyonight.setup({
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
    	end,
	})
end

local present, dark_notify = pcall(require, 'dark_notify')
if present then
	return
	dark_notify.run({
    	schemes = {
        	dark = 'tokyonight-moon',
        	--dark = 'oxocarbon',
        	light = 'tokyonight-day',
        	--light = 'oxocarbon',
    	}
	})
end
