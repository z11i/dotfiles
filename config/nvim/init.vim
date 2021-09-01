source ~/.config/nvim/plugins.vim

""""" Meta -------------------------------------------------------------------
" Auto reload nvim configs when they are changed
au BufWritePost ~/.config/nvim/*.{vim,lua} so $MYVIMRC
" Edit vimr configuration file
nnoremap <Leader>ve :e $MYVIMRC<CR>
" " Reload vimr configuration file
nnoremap <Leader>vr :source $MYVIMRC<CR>

" use space for :
" https://stackoverflow.com/q/9952031
nnoremap <space> :
"nnoremap : ;

""""" Navigation --------------------------------------------------------------
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

""""" Editor -----------------------------------------------------------------

"see https://www.reddit.com/r/vim/wiki/tabstop
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set ignorecase
set smartcase
set number "" relativenumber
set mouse+=a

" https://vi.stackexchange.com/a/16511
" Auto toggle command case sensitivity.
" In `:' it's insensitive; in `/' it's smart
" assumes set ignorecase smartcase
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set ignorecase
    autocmd CmdLineLeave : set smartcase
augroup END

augroup dynamic_number
    autocmd!
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END

" === netrw (default vim explorer) ==== "
" https://shapeshed.com/vim-netrw/
"let g:netrw_banner = 0 "remove banner
"let g:netrw_browse_split = 4 "preview when opening files
"let g:netrw_winsize = 12 "window size
"let g:netrw_liststyle = 3 "tree style listing
"let g:netrw_altv = 1
"" auto open netrw when enter vim
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Lexplore
"augroup END
"
" === NERDTree === "
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
            \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

"" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
"autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
"    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>N :NERDTreeFind<CR>

" https://vi.stackexchange.com/a/655
"set autochdir                   " Changes the cwd to the directory of the current
" buffer whenever you switch buffers.
set browsedir=current           " Make the file browser always open the current
" directory.

" auto save when focus is lost
" http://ideasintosoftware.com/vim-productivity-tips/
autocmd FocusLost * silent! wa

" quick vertical buffer
" http://ideasintosoftware.com/vim-productivity-tips/
nnoremap <leader>w <C-w>v<C-w>l

" fold by syntax (default is manual)
" https://unix.stackexchange.com/a/596686
set foldmethod=syntax
set foldlevelstart=99
nnoremap - za

""""" Buffer -----------------------------------------------------------------
set hidden " hide buffers when abandoned

""""" Autocomplete -----------------------------------------------------------
"""" deoplete
"let g:deoplete#enable_at_startup = 1
"call deoplete#custom#option('auto_complete_delay', 10)
"call deoplete#custom#option('auto_refresh_delay', 50)

" instructs deoplete to use omni completion for go files
"call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

" <TAB>: completion.
" https://stackoverflow.com/a/44271350
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

""" nvim-compe """
lua vim.o.completeopt = "menuone,noselect"

lua <<EOF
require'compe'.setup {
enabled = true;
autocomplete = true;
debug = false;
min_length = 1;
preselect = 'enable';
throttle_time = 80;
source_timeout = 200;
resolve_timeout = 800;
incomplete_delay = 400;
max_abbr_width = 100;
max_kind_width = 100;
max_menu_width = 100;
documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
    };

source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    --nvim_lua = true;
    --vsnip = true;
    --ultisnips = true;
    --luasnip = true;
    };
}
EOF

" autopair compat
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

"change documentation window's highlight group
highlight link CompeDocumentation NormalFloat

" === nvim-autopairs ===
lua <<EOF
require('nvim-autopairs').setup{}
require("nvim-autopairs.completion.compe").setup({
map_cr = true, --  map <CR> on insert mode
map_complete = true, -- it will auto insert `(` after select function or method item
auto_select = false,  -- auto select first item
})
EOF

""""" Search -----------------------------------------------------------------
" fzf
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>s :Rg<CR>
nnoremap <silent> <Leader>e :History<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>a :Commands<CR>

let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit' }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Fuzzy insert mode completion using fzf
" https://vim.fandom.com/wiki/Fuzzy_insert_mode_completion_(using_FZF)
function! PInsert2(item)
    let @z=a:item
    norm "zp
    call feedkeys('a')
endfunction

function! CompleteInf()
    let nl=[]
    let l=complete_info()
    for k in l['items']
        call add(nl, k['word']. ' : ' .k['info'] . ' '. k['menu'] )
    endfor
    call fzf#vim#complete(fzf#wrap({ 'source': nl,'reducer': { lines -> split(lines[0], '\zs :')[0] },'sink':function('PInsert2')}))
endfunction

imap <c-'> <CMD>:call CompleteInf()<CR>

""""" Terminal ---------------------------------------------------------------
" Escape to exit terminal input mode
tnoremap <Esc> <C-\><C-n>

""""" Language specific settings ---------------------------------------------
""" Generic LSP settings
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

-- Enable completion triggered by <c-x><c-o>
buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
local opts = { noremap=true, silent=false }

-- See `:help vim.lsp.*` for documentation on any of the below functions
buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

-- Set some keybinds conditional on server capabilities
if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>l", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>l", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'gopls' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
            }
        }
end

-- highlighting
require'nvim-treesitter.configs'.setup {
    highlight = {
    enable = true
    }
}
EOF

""" Go
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

" === go.nvim ===
lua <<EOF
require('go').setup()
EOF
" Auto gofmt on write
autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()

""""" Aesthetics -------------------------------------------------------------
set background=dark
set termguicolors

" cursorline based on active window
augroup CursorlineOnActiveWin
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
augroup END

try
    lua << EOF
    require("github-theme").setup({
    functionStyle = "italic",
    themeStyle = "dimmed",
    sidebars = {"qf", "vista_kind", "terminal", "packer"},

    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    colors = {hint = "orange", error = "#ff0000"}
    })
EOF
"let g:neodark#terminal_transparent = 1
"let g:neodark#use_256color = 1
"let g:neodark#background = '#202020'
catch
    colorscheme desert
endtry

" GUI configs
if has("gui_running")
    set guioptions -=m
    set guioptions -=T
    if has("gui_gtk2")
        set guifont=Inconsolata\ 12
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
endif

" === Vim airline ==== "
let g:airline_theme='dark'

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

"" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

" Enable extensions
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#branch#format = 2
let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#nerdtree_statusline = 1
let g:airline#extensions#tabline#enabled = 1

" enable experimental features >
" Currently: Enable Vim9 Script implementation
let g:airline_experimental = 1
" determine whether inactive windows should have the left section collapsed
" to only the filename of that buffer.  >
let g:airline_inactive_collapse=0
" Use alternative seperators for the statusline of inactive windows >
let g:airline_inactive_alt_sep=1
" enable iminsert detection >
let g:airline_detect_iminsert=0
" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1
" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'
" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]
" defines whether the preview window should be excluded from having its window
" statusline modified (may help with plugins which use the preview window
" heavily) >
let g:airline_exclude_preview = 0

