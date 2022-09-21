vim.g.mapleader = ' ' -- leader key is <Space>

vim.opt.shell='/bin/bash' -- Use bash as the shell. Better for plugin compatibility
vim.opt.hidden = true -- hide buffers when abandoned

-- Auto reload nvim configs when they are changed
vim.cmd [[
au BufWritePost ~/.config/nvim/*.{vim,lua} so $MYVIMRC
nnoremap <Leader>ve :e $MYVIMRC<CR>
nnoremap <Leader>vrc :source $MYVIMRC \| PackerCompile<CR>
nnoremap <Leader>vrs :source $MYVIMRC \| PackerSync<CR>
]]

-- filetype
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

vim.opt.tabstop=4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.mouse:append('a')
-- wrapping
vim.opt.wrap = true
vim.opt.linebreak = true
-- show indentation
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.showbreak=[[    ⤷]]
-- ident by an additional 2 characters on wrapped lines, when line >= 40 characters, put 'showbreak' at start of line
vim.opt.breakindentopt='shift:2,min:40,sbr'
-- looks
vim.opt.termguicolors = true
vim.opt.winblend=10 -- transparency of floating windows
vim.opt.pumblend=10 -- transparency of popup menus
vim.opt.cursorline = true

vim.cmd [[
" https://vi.stackexchange.com/a/16511
" Auto toggle command case sensitivity.
" In `:' it's insensitive; in `/' it's smart
" assumes set ignorecase smartcase
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END

" auto save when focus is lost
" http://ideasintosoftware.com/vim-productivity-tips/
autocmd FocusLost * silent! wa


set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99

" time-based background toggle 7am-6pm
" https://askubuntu.com/questions/743610
fun! s:set_bg(timer_id)
    let &background = (strftime('%H') >= 07 && strftime('%H') < 18 ? 'light' : 'dark')
endfun
call timer_start(1000 * 60, function('s:set_bg'), {'repeat': -1})
call s:set_bg(0)  " Run on startup
]]
