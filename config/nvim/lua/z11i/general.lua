vim.g.mapleader = ' ' -- leader key is <Space>

vim.opt.shell='/bin/bash' -- Use bash as the shell. Better for plugin compatibility
vim.opt.hidden = true -- hide buffers when abandoned

-- Auto reload nvim configs when they are changed
vim.cmd [[
au BufWritePost ~/.config/nvim/*.{vim,lua} so $MYVIMRC
nnoremap <Leader>ve :e $MYVIMRC<CR>
nnoremap <Leader>vr :source $MYVIMRC<CR>
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
"To use `ALT+{h,j,k,l}` to navigate windows from any mode: >
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" split current buffer and go to previous buffer
nnoremap <A-\> <C-w>v<C-o>
nnoremap <A--> <C-w>s<C-o>

" Cycle through last used buffers with Ctrl-\
nnoremap <C-\> <Cmd>e#<CR>
" New/Close buffer
nnoremap <A-t> <Cmd>enew<CR>


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

" quick vertical buffer
" http://ideasintosoftware.com/vim-productivity-tips/
nnoremap <leader>\| <C-w>v<C-w>l
" quick horizontal buffer
nnoremap <leader>- <C-w>s<C-w>j

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
nnoremap - za

" Alt-A in normal mode selects all
nnoremap <A-a> ggVG
" Alt-C in visual mode copies
vnoremap <A-c> "+y
" Alt-V in insert mode pastes
inoremap <A-v> <Esc>"+p
" Alt-S in normal and insert mode saves
nnoremap <A-s> <Cmd>w<CR>
inoremap <A-s> <Esc><Cmd>w<CR>


" <TAB>: completion.
" https://stackoverflow.com/a/44271350
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
]]
