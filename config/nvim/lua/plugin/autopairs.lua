local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
npairs.setup({})
-- you need setup cmp first put this after cmp.setup()
-- setup nvim-cmp
local ok, cmp = pcall(require, "cmp")
if ok then
	local cmp_autopairs = require('nvim-autopairs.completion.cmp')
	cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
end
