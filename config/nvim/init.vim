source ~/.config/nvim/plugins.vim

""""" Meta -------------------------------------------------------------------
" leader key is <Space>
let mapleader = "\<space>"

" Use ; as : for easier command typing
" Functionality replaced by lightspeed
nnoremap ; :
nnoremap : :!

" Use bash as the shell. Better for plugin compatibility
set shell=/bin/bash

" Auto reload nvim configs when they are changed
au BufWritePost ~/.config/nvim/*.{vim,lua} so $MYVIMRC
" Edit vimr configuration file
nnoremap <Leader>ve :e $MYVIMRC<CR>
" Reload vimr configuration file
nnoremap <Leader>vr :source $MYVIMRC<CR>

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

" Cycle through last used buffers with Ctrl-\
nnoremap <C-\> <Cmd>e#<CR>

" cycle buffer files
nnoremap <A-[> <Cmd>BufferLineCyclePrev<CR>
nnoremap <A-]> <Cmd>BufferLineCycleNext<CR>

" New/Close buffer
nnoremap <A-t> <Cmd>enew<CR>
nnoremap <A-w> <Cmd>bdelete<CR>

" === NvimTree === "
nnoremap <F1> :NvimTreeToggle<CR>

let g:nvim_tree_highlight_opened_files = 3
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_gitignore = 0 "0 by default, 0 means not ignoring
let g:nvim_tree_window_picker_exclude = {'filetype':["packer","qf","help","Outline"]}

highlight NvimTreeFolderIcon guibg=blue
lua <<EOF
require'nvim-tree'.setup {
    disable_netrw       = true,
    hijack_netrw        = true,
    open_on_setup       = false,
    ignore_ft_on_setup  = {},
    auto_close          = false,
    open_on_tab         = false,
    hijack_cursor       = false,
    update_cwd          = false,
    diagnostics = {
        enable = true,
    },
    update_focused_file = {
        enable      = true,
        update_cwd  = false,
        ignore_list = {}
    },
    system_open = {
        cmd  = nil,
        args = {}
    },
    view = {
        width = '18%',
        side = 'left',
        auto_resize = true,
        mappings = {
            custom_only = false,
            list = {}
        }
    }
}
EOF

" === FTerm === "
nnoremap <F12> :lua require('FTerm').toggle()<CR>
tnoremap <F12> <C-\><C-N>:lua require('FTerm').toggle()<CR>

" === Symbols-outline === "
nnoremap <F5> :SymbolsOutline<CR>
lua <<EOF
vim.g.symbols_outline = {
    width = 20,
    highlight_hovered_item = true,
    keymaps = {
        close = {},
        goto_location = {"<Cr>", "<2-LeftMouse>"},
    },
    symbols = {
        File = {icon = "", hl = "TSURI"},
        Module = {icon = "", hl = "TSNamespace"},
        Namespace = {icon = "", hl = "TSNamespace"},
        Package = {icon = "", hl = "TSNamespace"},
        Class = {icon = "", hl = "TSType"},
        Method = {icon = "", hl = "TSMethod"},
        Property = {icon = "", hl = "TSMethod"},
        Field = {icon = "", hl = "TSField"},
        Constructor = {icon = "", hl = "TSConstructor"},
        Enum = {icon = "ℰ", hl = "TSType"},
        Interface = {icon = "ﰮ", hl = "TSType"},
        Function = {icon = "", hl = "TSFunction"},
        Variable = {icon = "", hl = "TSConstant"},
        Constant = {icon = "", hl = "TSConstant"},
        String = {icon = "", hl = "TSString"},
        Number = {icon = "#", hl = "TSNumber"},
        Boolean = {icon = "⊨", hl = "TSBoolean"},
        Array = {icon = "", hl = "TSConstant"},
        Object = {icon = "", hl = "TSType"},
        Key = {icon = "", hl = "TSType"},
        Null = {icon = "ﳠ", hl = "TSType"},
        EnumMember = {icon = "", hl = "TSField"},
        Struct = {icon = "", hl = "TSType"},
        Event = {icon = "🗲", hl = "TSType"},
        Operator = {icon = "+", hl = "TSOperator"},
        TypeParameter = {icon = "𝙏", hl = "TSParameter"}
    }
}
EOF

""" lightspeed
lua <<EOF
require('lightspeed').setup({
    x_mode_prefix_key = '<tab>',
    exit_after_idle_msecs = { labeled = nil, unlabeled = 1000 },
})
EOF
silent! unmap s
silent! unmap S
nmap \ <Plug>Lightspeed_s
vmap \ <Plug>Lightspeed_s
omap \ <Plug>Lightspeed_s
nmap \| <Plug>Lightspeed_S
vmap \| <Plug>Lightspeed_S
omap \| <Plug>Lightspeed_S

""""" Editor -----------------------------------------------------------------
""" Generic LSP settings
lua require("lsp")
" LSP extensions
autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
nnoremap K             :lua vim.lsp.buf.hover()<CR>
nnoremap <C-k>         :lua vim.lsp.buf.signature_help()<CR>
inoremap <C-k>         <Esc>:lua vim.lsp.buf.signature_help()<CR>a
nnoremap <Leader>i     :lua vim.lsp.buf.implementation()<CR>
nnoremap <Leader>d     :lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>D     :lua vim.lsp.buf.declaration()<CR>
nnoremap <Leader>l     :lua vim.lsp.buf.formatting()<CR>
nnoremap <Leader>r     :lua vim.lsp.buf.references()<CR>
nnoremap <F2>          :lua vim.lsp.buf.rename()<CR>
nnoremap <Leader>t     :lua vim.lsp.buf.type_definition()<CR>
nnoremap <Leader>e     :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

"see https://www.reddit.com/r/vim/wiki/tabstop
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set ignorecase
set smartcase
set number
set mouse+=a

" wrapping
set wrap
set linebreak

" show indentation
set smartindent
set autoindent
set breakindent
set showbreak=\ \ \ \ ⤷
" ident by an additional 2 characters on wrapped lines, when line >= 40 characters, put 'showbreak' at start of line
set breakindentopt=shift:2,min:40,sbr

" https://vi.stackexchange.com/a/16511
" Auto toggle command case sensitivity.
" In `:' it's insensitive; in `/' it's smart
" assumes set ignorecase smartcase
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END

"augroup dynamic_number
"    autocmd!
"    autocmd InsertEnter * :set norelativenumber
"    autocmd InsertLeave * :set relativenumber
"augroup END

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

" === nvim-spectre ==="
nnoremap <leader>/R :lua require('spectre').open()<CR>
nnoremap <leader>/r viw:lua require('spectre').open_file_search()<cr>

" === fugitive === "
nnoremap <C-g><C-g> :Git 
" === gitsigns ==="
lua <<EOF
require('gitsigns').setup({
    numhl = true,
    word_diff = true,
    current_line_blame = true,
    signs = {
        delete = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    },
    diff_opts = {
        algorithm = 'histogram',
        internal = true,
    },
    keymaps = {
        noremap = true,

        ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
        ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

        ['n <C-g>g'] = ':Gitsigns ',
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

" === nvim-comment === "
lua <<EOF
require('nvim_comment').setup({
    line_mapping = "<leader>cc",
    operator_mapping = "<leader>c",
    comment_empty = false,
})
EOF

""""" Autocomplete -----------------------------------------------------------
" <TAB>: completion.
" https://stackoverflow.com/a/44271350
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" === nvim-cmp ===
set completeopt=menu,menuone,noselect
lua <<EOF
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            -- For `vsnip` user.
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
        end,
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert })
            elseif vim.fn["vsnip#available"]() == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),
        ['.'] = cmp.mapping(function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }, fallback)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
        }, {
            { name = 'buffer' },
            { name = 'path' },
        })
    })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})
cmp.setup.cmdline('?', {
    sources = {
        { name = 'buffer' }
    }
})

-- Setup lspconfig.
require('lspconfig')['gopls'].setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}
-- rust-analyzer is setup via rust-tools
EOF

" === nvim-autopairs ===
lua <<EOF
local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
npairs.setup({
})
-- you need setup cmp first put this after cmp.setup()
-- setup nvim-cmp
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
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
" === Telescope === "
lua <<EOF
local actions = require('telescope.actions')
require'telescope'.setup {
    defaults = {
        dynamic_preview_title = true,
        layout_strategy = "flex",
        scroll_strategy = 'cycle',
        winblend = 0,
        layout_config = {
            flex = {
                horizontal = {
                    preview_width = 0.6,
                    },
                vertical = {
                    preview_height = 0.4,
                    },
                flip_columns = 140,
                flip_lines = 10,
                },
            preview_cutoff = 10,
                },
        file_ignore_patterns = { 'tags' },
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<c-s>"] = actions.select_horizontal,
                ["<c-x>"] = actions.delete_buffer,
                },
            },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            },
        },
    pickers = {
        find_files = {
            --no_ignore = false,
            },
        live_grep = {
            path_display = {shorten = {len = 2, exclude = {-1}}},
            },
        lsp_code_actions = {
            theme = "cursor",
            },
        oldfiles = {
            only_cwd = true,
            }
        }
    }
EOF
nnoremap <Leader><Leader> :Telescope<CR>
nnoremap <Leader>f :Telescope find_files<CR>
nnoremap <Leader>F :Telescope find_files hidden=true no_ignore=true<CR>
nnoremap <Leader>s :Telescope live_grep<CR>
nnoremap <Leader>S :lua require('telescope.builtin').live_grep({vimgrep_arguments={'rg','--color=never','--no-heading','--column','-HS', '-uu'}})<CR>
nnoremap <Leader>h :Telescope oldfiles only_cwd=true<CR>
nnoremap <Leader>b :Telescope buffers<CR>
nnoremap <Leader>a :Telescope commands<CR>
nnoremap <Leader>o :Telescope lsp_document_symbols<CR>
nnoremap <Leader>O :Telescope lsp_dynamic_workspace_symbols<CR>
nnoremap <Leader>gd :Telescope lsp_document_diagnostics<CR>
nnoremap <Leader>gD :Telescope lsp_workspace_diagnostics<CR>
nnoremap <Leader>g. :Telescope lsp_code_actions<CR>

""""" Terminal ---------------------------------------------------------------
" Escape to exit terminal input mode
tnoremap <Esc> <C-\><C-n>

""""" Language specific settings ---------------------------------------------
""" Go
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

" === go.nvim ===

" Auto gofmt on write
autocmd BufWritePre *.go :lua require('go.format').goimport()

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
    lsp_on_attach = false, -- use on_attach from go.nvim
    lsp_codelens = true,
    dap_debug = true,
})

local protocol = require'vim.lsp.protocol'
EOF

" === vim-go ===
"let g:go_code_completion_enabled = 0
"let g:go_auto_type_info = 0
"let g:go_auto_sameids = 0
"let g:go_fmt_autosave = 1
"let g:go_textobj_enabled = 0
"let g:go_textobj_include_variable = 0
"let g:go_fold_enable = []
"let g:go_highlight_array_whitespace_error = 0
"let g:go_highlight_chan_whitespace_error = 0
"let g:go_highlight_extra_types = 0
"let g:go_highlight_space_tab_error = 0
"let g:go_highlight_trailing_whitespace_error = 0
"let g:go_highlight_operators = 0
"let g:go_highlight_functions = 0
"let g:go_highlight_function_parameters = 0
"let g:go_highlight_function_calls = 0
"let g:go_highlight_types = 0
"let g:go_highlight_fields = 0
"let g:go_highlight_build_constraints = 0
"let g:go_highlight_generate_tags = 0
"let g:go_highlight_string_spellcheck = 0
"let g:go_highlight_format_strings = 0
"let g:go_highlight_variable_declarations = 0
"let g:go_highlight_variable_assignments = 0
"let g:go_highlight_diagnostic_errors = 0
"let g:go_highlight_diagnostic_warnings = 0

""" Markdown
au BufRead,BufNewFile *.md setlocal textwidth=80

""" JSON"
" 2-space indent
au FileType json set shiftwidth=2

""""" Aesthetics -------------------------------------------------------------
set background=dark
set termguicolors
set winblend=10 " transparency of floating windows
set pumblend=10 " transparency of popup menus
set cursorline

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
    "let g:gruvbox_material_palette = 'mix'
    "let g:gruvbox_material_ui_contrast = 'hard'
    "let g:gruvbox_material_enable_bold = 1
    "let g:gruvbox_material_enable_italic = 1
    "let g:gruvbox_material_transparent_background = 1
    "let g:gruvbox_material_visual = 'reverse'
    "let g:gruvbox_material_menu_selection_background = 'green'
    "let g:gruvbox_material_diagnostic_virtual_text = 'colored'
    "let g:gruvbox_material_current_word = 'underline'
    "colorscheme gruvbox-material

    function! s:sonokai_custom() abort
        " Link a highlight group to a predefined highlight group.
        " See `colors/sonokai.vim` for all predefined highlight groups.
        highlight! link TSField Purple
        highlight! link TSFuncBuiltin GreenItalic
        highlight! link TSProperty Purple
        highlight! link TSType Blue
        highlight! link TSParameter Orange
        highlight! link TSParameterReference Orange

        " Initialize the color palette.
        " The parameter is a valid value for `g:sonokai_style`,
        let l:palette = sonokai#get_palette('default')
    endfunction

    augroup SonokaiCustom
        autocmd!
        autocmd ColorScheme sonokai call s:sonokai_custom()
    augroup END

    let g:sonokai_enable_italic = 1
    let g:sonokai_disable_italic_comment = 0
    colorscheme sonokai
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
        theme = 'material',
        section_separators = { left = '', right = ''},
        component_separators = { left = '', right = ''},
        disabled_filetypes = {}
        },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {
            {'filename', file_status = true, path = 1},
            {'lsp_progress'},
        },
        lualine_x = {'filetype',
            {
                'diagnostics',
                sources = {'nvim_lsp'},
                sections = {'error', 'warn', 'info', 'hint'},
                symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '},
                colored = true,
                update_in_insert = true,
                always_visible = false,
            }
        },
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
    extensions = {'quickfix', 'nvim-tree', 'fugitive'},
    }
EOF

" === bufferline === "
lua <<EOF
require("bufferline").setup {
    options = {
        numbers = "ordinal",
        buffer_close_icon= "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is deduplicated
        tab_size = 18,
        diagnostics = "nvim_lsp",
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "thin",
        offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "center"}},
        sort_by = "relative_directory",
        custom_filter = function(buf, buf_nums)
            -- dont show help or qf buffers in the bufferline
            if vim.bo[buf].filetype == "help" then
                return false
            elseif vim.bo[buf].filetype == "qf" then
                return false
            end
            return true
        end,
    },
}
EOF

" === nvim-colorizer === "
lua <<EOF
require 'colorizer'.setup {
    'vim';
    'css';
    'javascript';
    'javascriptreact';
    'typescript';
    'typescriptreact';
    html = {
        mode = 'foreground';
    };
}
EOF

" === marks.nvim === "
lua <<EOF
require'marks'.setup {
    -- how often (in ms) to redraw signs/recompute mark positions.
    -- higher values will have better performance but may cause visual lag,
    -- while lower values may cause performance penalties. default 150.
    refresh_interval = 50,
    -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
    -- marks, and bookmarks.
    -- can be either a table with all/none of the keys, or a single number, in which case
    -- the priority applies to all marks.
    -- default 10.
    --sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
    -- disables mark tracking for specific filetypes. default {}
    excluded_filetypes = {},
    mappings = {
        preview = "qm",
        next = "M",
        prev = "<C-m>",
    }
}
EOF

" === lazygit === "
nnoremap <silent> <leader>gg :LazyGit<CR>
