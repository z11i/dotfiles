local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
npairs.setup({})
-- you need setup cmp first put this after cmp.setup()
-- setup nvim-cmp
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
