source ~/.config/nvim/plugins.vim

""""" Meta -------------------------------------------------------------------
" Auto reload nvim configs when they are changed
au BufWritePost ~/.config/nvim/*.{vim,lua} so $MYVIMRC
" Edit vimr configuration file
nnoremap <Leader>ve :e $MYVIMRC<CR>
" Reload vimr configuration file
nnoremap <Leader>vr :source $MYVIMRC<CR>

" use space for :
" https://stackoverflow.com/q/9952031
nnoremap <space> :

""""" Navigation --------------------------------------------------------------
set hidden " hide buffers when abandoned

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

" go back and forth buffer files
nnoremap gn <Cmd>bn<CR>
nnoremap gp <Cmd>bp<CR>

" === NvimTree === "
nnoremap <leader>n :NvimTreeToggle<CR>
nnoremap <leader>N :NvimTreeFindFile<CR>

let g:nvim_tree_width = '12%'

let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_lsp_diagnostics = 1 "0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
let g:nvim_tree_indent_markers = 0 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_follow = 0 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:nvim_tree_auto_open = 1 "0 by default, opens the tree when typing `vim $DIR` or `vim`
let g:nvim_tree_auto_close = 0 "0 by default, closes the tree when it's the last window
let g:nvim_tree_disable_netrw = 1 "1 by default, disables netrw
let g:nvim_tree_hijack_netrw = 1 "1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
let g:nvim_tree_gitignore = 1 "0 by default

highlight NvimTreeFolderIcon guibg=blue

" === FTerm === "
lua require('FTerm').setup()
nnoremap <F12> :lua require('FTerm').toggle()<CR>
tnoremap <F12> <C-\><C-N>:lua require('FTerm').toggle()<CR>

""""" Editor -----------------------------------------------------------------

"see https://www.reddit.com/r/vim/wiki/tabstop
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set ignorecase
set smartcase
set number relativenumber
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

" auto save when focus is lost
" http://ideasintosoftware.com/vim-productivity-tips/
autocmd FocusLost * silent! wa

" quick vertical buffer
" http://ideasintosoftware.com/vim-productivity-tips/
nnoremap <leader>w <C-w>v<C-w>l

" fold by syntax (default is manual)
" https://unix.stackexchange.com/a/596686
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
nnoremap - za

" === nvim-spectre ==="
nnoremap <leader>R :lua require('spectre').open()<CR>
nnoremap <leader>r viw:lua require('spectre').open_file_search()<cr>

" === gitsigns ==="
lua <<EOF
require('gitsigns').setup({
  keymaps = {
    noremap = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <C-g><C-g>'] = ':Gitsigns ',
    ['n <C-g><C-s>h'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <C-g><C-s>h'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <C-g><C-s>u'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <C-g><C-s>b'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    ['n <C-g><C-r>h'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <C-g><C-r>h'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <C-g><C-r>b'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <C-g><C-r>B'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',
    ['n <C-g><C-p>'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <C-g><C-b>'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
})
EOF

" === treesitter-context === "
lua <<EOF
require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    throttle = true, -- Throttles plugin updates (may improve performance)
}
EOF

" === nvim-bqf === "
hi BqfPreviewBorder guifg=#50a14f ctermfg=71
hi link BqfPreviewRange Search
lua <<EOF
require('bqf').setup({
    auto_enable = true,
    magic_window = true,
    preview = {
        win_height = 15,
    },
})
EOF

""""" Autocomplete -----------------------------------------------------------
" <TAB>: completion.
" https://stackoverflow.com/a/44271350
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" === nvim-compe ===
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
auto_select = true,  -- auto select first item
})
EOF

" === which-key === "
set timeoutlen=500
lua << EOF
require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    }
EOF

""""" Search -----------------------------------------------------------------
" === fzf-lua === "
lua require("fzf")
nnoremap <silent> <Leader>A :FzfLua<CR>
nnoremap <silent> <Leader>f :FzfLua files<CR>
nnoremap <silent> <Leader>s :FzfLua live_grep<CR>
nnoremap <silent> <Leader>e :FzfLua oldfiles<CR>
nnoremap <silent> <Leader>b :FzfLua buffers<CR>
nnoremap <silent> <Leader>a :FzfLua commands<CR>
nnoremap <silent> <Leader>o :FzfLua lsp_document_symbols<CR>
nnoremap <silent> <Leader>O :FzfLua lsp_workspace_symbols<CR>
nnoremap <silent> <Leader>?o :FzfLua lsp_document_diagnostics<CR>
nnoremap <silent> <Leader>?O :FzfLua lsp_workspace_diagnostics<CR>

""""" Terminal ---------------------------------------------------------------
" Escape to exit terminal input mode
tnoremap <Esc> <C-\><C-n>

""""" Language specific settings ---------------------------------------------
""" Generic LSP settings
lua require("lsp")
" LSP extensions
autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}

""" Go
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

" === go.nvim ===
lua <<EOF
require 'go'.setup({
goimport = 'gopls', -- if set to 'gopls' will use golsp format
gofmt = 'gopls', -- if set to gopls will use golsp format
max_line_len = 120,
tag_transform = false,
test_dir = '',
comment_placeholder = '<>',
lsp_cfg = false, -- false: use your own lspconfig
lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
lsp_on_attach = true, -- use on_attach from go.nvim
dap_debug = true,
})

local protocol = require'vim.lsp.protocol'
EOF

" Auto gofmt on write
autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()

""""" Aesthetics -------------------------------------------------------------
set background=dark
set termguicolors
set winblend=10 " transparency of floating windows
set pumblend=10 " transparency of popup menus

try
""    lua << EOF
""    require("github-theme").setup({
""    themeStyle = 'dimmed',
""    keywordStyle = 'italic',
""    sidebars = {"qf", "vista_kind", "terminal", "packer"},
""    darkSidebar = true,
""    darkFloat = true,
""    hideEndOfBuffer = true,
""    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
""    colors = {hint = "orange", error = "#ff0000"}
""    })
""EOF
    let g:gruvbox_material_palette = 'mix'
    let g:gruvbox_material_ui_contrast = 'hard'
    let g:gruvbox_material_enable_bold = 1
    let g:gruvbox_material_enable_italic = 1
    let g:gruvbox_material_transparent_background = 1
    let g:gruvbox_material_visual = 'reverse'
    let g:gruvbox_material_menu_selection_background = 'green'
    let g:gruvbox_material_diagnostic_virtual_text = 'colored'
    let g:gruvbox_material_current_word = 'underline'
    colorscheme gruvbox-material
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

" === lualine === "
lua <<EOF
require'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = 'gruvbox',
        section_separators = {'', ''},
        component_separators = {'', ''},
        disabled_filetypes = {}
        },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
        },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
        },
    tabline = {},
    extensions = {'quickfix', 'nvim-tree'},
    }
EOF

" === buftabline === "
lua require("buftabline").setup {}
