vim.g.mapleader = ' ' -- leader key is <Space>

vim.opt.shell='/bin/bash' -- Use bash as the shell. Better for plugin compatibility
vim.opt.hidden = true -- hide buffers when abandoned

-- Auto reload nvim configs when they are changed
vim.cmd [[
au BufWritePost ~/.config/nvim/*.{vim,lua} so $MYVIMRC
nnoremap <Leader>ve :e $MYVIMRC<CR>
nnoremap <Leader>vrc :source $MYVIMRC<CR>:PackerCompile<CR>
nnoremap <Leader>vrs :source $MYVIMRC<CR>:PackerSync<CR>
]]


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
vim.opt.background='dark'
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
]]
