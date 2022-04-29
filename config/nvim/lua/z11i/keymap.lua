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

" quick vertical buffer
" http://ideasintosoftware.com/vim-productivity-tips/
nnoremap <leader>\| <C-w>v<C-w>l
" quick horizontal buffer
nnoremap <leader>- <C-w>s<C-w>j
" Use - to expand/collapse folds
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

" <leader>cd to change pwd to the current buffer and print pwd
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" <TAB>: completion.
" https://stackoverflow.com/a/44271350
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
]]

-- plugin keymaps that are not in plugins.lua because of lazyloading or something
vim.cmd [[nnoremap <F3> :NvimTreeFindFileToggle<CR>]]
