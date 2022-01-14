local fn = vim.fn

-- Auto install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print 'Installing packer. Neovim will be closed and reopened...'
    vim.cmd [[packadd packer.nvim]]
end

-- -- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
-- augroup packer_user_config
-- autocmd!
-- autocmd BufWritePost plugins.lua source <afile> | PackerSync
-- augroup end
-- ]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

return require('packer').startup(function(use)
    use {
        'wbthomason/packer.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-lua/popup.nvim'},
        },
    }

    ---- NAVIGATION plugins {{{
    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        config = function()
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
                            flip_columns = 160,
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
            require('telescope').load_extension('fzf')
            vim.cmd [[nnoremap <Leader><Leader> :Telescope<CR>]]
            vim.cmd [[nnoremap <Leader>ff :Telescope find_files<CR>]]
            vim.cmd [[nnoremap <Leader>fF :Telescope find_files hidden=true no_ignore=true<CR>]]
            vim.cmd [[nnoremap <Leader>fs :Telescope live_grep<CR>]]
            vim.cmd [[nnoremap <Leader>fg :Telescope grep_string<CR>]]
            vim.cmd [[nnoremap <Leader>fS :lua require('telescope.builtin').live_grep({vimgrep_arguments={'rg','--color=never','--no-heading','--column','-HS', '-uu'}})<CR>]]
            vim.cmd [[nnoremap <Leader>fh :Telescope oldfiles only_cwd=true<CR>]]
            vim.cmd [[nnoremap <Leader>fb :Telescope buffers<CR>]]
            vim.cmd [[nnoremap <Leader>fa :Telescope commands<CR>]]
            vim.cmd [[nnoremap <Leader>fo :Telescope lsp_document_symbols<CR>]]
            vim.cmd [[nnoremap <Leader>fO :Telescope lsp_dynamic_workspace_symbols<CR>]]
            vim.cmd [[nnoremap <Leader>fr :Telescope lsp_references<CR>]]
            vim.cmd [[nnoremap <Leader>ft :Telescope lsp_type_definitions<CR>]]
            vim.cmd [[nnoremap <Leader>fi :Telescope lsp_implementations<CR>]]
            vim.cmd [[nnoremap <Leader>f. :Telescope lsp_code_actions<CR>]]
            vim.cmd [[nnoremap <Leader>gc :Telescope git_commits theme=ivy<CR>]]
            vim.cmd [[nnoremap <Leader>gb :Telescope git_bcommits theme=ivy<CR>]]
            vim.cmd [[nnoremap <Leader>gs :Telescope git_status theme=ivy<CR>]]
            vim.cmd [[nnoremap <Leader>gb :Telescope git_branches theme=ivy<CR>]]
            vim.cmd [[nnoremap <Leader>p :Telescope resume<CR>]]
        end,
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-fzf-native.nvim', run = {'make'} },
        }
    }
    -- Lightspeed: motion and jump to location
    use {
        'ggandor/lightspeed.nvim',
        config = function()
            vim.g.lightspeed_no_default_keymaps = true
            require('lightspeed').setup({
                exit_after_idle_msecs = { labeled = nil, unlabeled = 1000 },
            })
            -- Use ; as : for easier command typing
            vim.cmd [[nnoremap ; :]]
            vim.cmd [[nnoremap : :!]]
            vim.cmd [[nmap \ <Plug>Lightspeed_s]]
            vim.cmd [[vmap \ <Plug>Lightspeed_s]]
            vim.cmd [[omap \ <Plug>Lightspeed_s]]
            vim.cmd [[nmap \| <Plug>Lightspeed_S]]
            vim.cmd [[vmap \| <Plug>Lightspeed_S]]
            vim.cmd [[omap \| <Plug>Lightspeed_S]]
        end,
        requires = { {'tpope/vim-repeat', opt = true} }
    }
    -- }}}
    -- nvim-tree: file explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { {'kyazdani42/nvim-web-devicons'} },
        config = function()
            vim.cmd [[nnoremap <F3> :NvimTreeToggle<CR>]] -- TODO: doesn't work when lazy loading
            vim.g.nvim_tree_highlight_opened_files = 3
            vim.g.nvim_tree_indent_markers = 1
            vim.g.nvim_tree_window_picker_exclude = {filetype = {'packer','qf','help','Outline'}}
            require'nvim-tree'.setup {
                diagnostics = { enable = true },
                git = { ignore = false },
                update_focused_file = {
                    enable      = true,
                    update_cwd  = false,
                    ignore_list = {}
                },
                view = {
                    width = '18%',
                    auto_resize = true,
                }
            }
        end
    }

    ---- Treesitter {{{
    use { 'nvim-treesitter/nvim-treesitter', run = {':TSUpdate', ':TSInstall maintained'} }
    -- Create your own textobjects using tree-sitter queries
    use {'nvim-treesitter/nvim-treesitter-textobjects'}
    -- Debug tree-sitter
    use {'nvim-treesitter/playground', opt = true, cmd = 'TSPlaygroundToggle'}
    -- Show code context (show function if scrolled beyond screen)
    use {'romgrk/nvim-treesitter-context', config = function()
        require'treesitter-context'.setup{ enable = true, throttle = true }
    end}
    --}}}

    ---- LSP plugins {{{
    -- Quickstart configurations for the Nvim LSP client
    use {'neovim/nvim-lspconfig'}
    -- LSP signature hint as you type
    use {'ray-x/lsp_signature.nvim', config = function() require('lsp_signature').setup() end}
    -- shows type annotations as virtual text
    use {'jubnzv/virtual-types.nvim'}
    -- Go Neovim plugin, based on nvim-lsp, treesitter and Dap
    use {
        'ray-x/go.nvim',
        ft = {'go', 'gomod'},
        requires = {
            {'neovim/nvim-lspconfig', opt = true},
            {'ray-x/lsp_signature.nvim', opt = true},
            {'jubnzv/virtual-types.nvim', opt = true}},
    }
    -- Battery-included rust lsp setup
    use {
        'simrat39/rust-tools.nvim',
        ft = {'rust'},
        config = function() require('rust-tools').setup() end,
        requires = {{'neovim/nvim-lspconfig', opt = true}}}
    -- LSP extensions
    use {'nvim-lua/lsp_extensions.nvim',
        -- autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
        config = function() require('lsp_extensions').inlay_hints{} end,
        ft = {'rust'},
        requires = {{'neovim/nvim-lspconfig', opt = true}}}
    -- Diagnostics window
    use {
        "folke/trouble.nvim",
        requires = {"kyazdani42/nvim-web-devicons"},
        config = function()
            require("trouble").setup {}
            vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", {silent = true, noremap = true})
            vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", {silent = true, noremap = true})
            vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", {silent = true, noremap = true})
            vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", {silent = true, noremap = true})
            vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", {silent = true, noremap = true})
            vim.api.nvim_set_keymap("n", "<leader>xr", "<cmd>Trouble lsp_references<cr>", {silent = true, noremap = true})
            vim.api.nvim_set_keymap("n", "<leader>xi", "<cmd>Trouble lsp_implementations<cr>", {silent = true, noremap = true})
        end
    }
    -- Generate Go stub for interface on a type
    use {
		'edolphin-ydf/goimpl.nvim',
        opt = true, ft = {'go'},
		requires = {
			{'nvim-lua/plenary.nvim'},
            {'nvim-lua/popup.nvim'},
			{'nvim-telescope/telescope.nvim'},
			{'nvim-treesitter/nvim-treesitter'},
		},
		config = function()
			require'telescope'.load_extension'goimpl'
            vim.api.nvim_set_keymap('n', '<leader>.i', [[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]], {noremap=true, silent=true})
		end,
    }
    --}}}

    ---- Git integration {{{
    -- Enable git changes to be shown in sign column
    use { 'tpope/vim-fugitive' }
    -- Git signs written in pure lua
    use {
        'lewis6991/gitsigns.nvim',
        config = function()

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
        end,
    }
    --}}}

    ---- EDITING {{{
    -- Copilot
    use {
        'github/copilot.vim', config = function()
            vim.g.copilot_filetypes = { xml = false, TelescopePrompt = false }
        end,
    }
    -- Autocomplete
    use {
        'hrsh7th/nvim-cmp',
        config = function()
            vim.opt.completeopt='menu,menuone,noselect'
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
                    { name = 'buffer', keyword_length = 2, max_item_count = 7 },
                }
            })
            cmp.setup.cmdline('?', {
                sources = {
                    { name = 'buffer', keyword_length = 2, max_item_count = 7 },
                }
            })
            -- Setup lspconfig.
            require('lspconfig')['gopls'].setup {
                capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
            }
            -- rust-analyzer is setup via rust-tools
        end,
        requires = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-vsnip'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/vim-vsnip'},
            {'hrsh7th/vim-vsnip-integ'},
        },
    }
    -- Better quickfix window in Neovim
    use {'kevinhwang91/nvim-bqf', opt = true, ft = 'qf', requires = {'junegunn/fzf'}, config = function()
        vim.cmd [[hi BqfPreviewBorder guifg=#50a14f ctermfg=71]]
        vim.cmd [[hi link BqfPreviewRange Search]]
        require('bqf').setup({
            auto_enable = true,
            magic_window = true,
            auto_resize_height = true,
        })
    end}
    -- Comments
    use {'numToStr/Comment.nvim', config = function () require('Comment').setup() end}
    -- Move lines up/down
    use {'matze/vim-move', config = function()
        vim.g.move_map_keys = 0 -- disable default key maps
        vim.cmd [[vmap J <Plug>MoveBlockDown]]
        vim.cmd [[vmap K <Plug>MoveBlockUp]]
        vim.cmd [[vmap H <Plug>MoveBlockLeft]]
        vim.cmd [[vmap L <Plug>MoveBlockRight]]
    end}
    -- auto complete pairs
    use {'windwp/nvim-autopairs', config = function()
        local npairs = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")
        npairs.setup({})
        -- you need setup cmp first put this after cmp.setup()
        -- setup nvim-cmp
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
    end}
    -- Keyboard shortcut cheatsheet
    use {'folke/which-key.nvim', config = function ()
        vim.opt.timeoutlen=500
        require("which-key").setup {}
    end}
    -- View marks
    use {
        'chentau/marks.nvim',
        config = function()
            require'marks'.setup {
                refresh_interval = 150,
                excluded_filetypes = {},
                mappings = {}
            }
        end,
    }
    -- Trailing whitespace highlighting & automatic fixing
    use {'ntpeters/vim-better-whitespace' }
    --}}}

    ---- Testing {{{
    use {'vim-test/vim-test'}
    use {'sebdah/vim-delve'}
    --}}}

    ---- THEME plugins {{{
    use {
        'rebelot/kanagawa.nvim',
        config = function() require('z11i/theme/kanagawa') end,
    }
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            vim.g.indent_blankline_context_patterns = {'class', 'function', 'method', '^if', '^for', 'switch', 'case', 'declaration', 'literal', 'statement'}
            require("indent_blankline").setup {
                -- for example, context is off by default, use this to turn it on
                show_current_context = true,
                use_treesitter = true,
            }
        end
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { {'arkav/lualine-lsp-progress' } },
        config = function()
            require'lualine'.setup {
                options = {
                    icons_enabled = true,
                    theme = 'kanagawa',
                    section_separators = { left = '', right = ''},
                    component_separators = { left = '', right = ''},
                    disabled_filetypes = {'aerial'}
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
                            sources = {'nvim_diagnostic'},
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
        end,
    }
    use {
        'kdheepak/tabline.nvim',
        config = function()
            require'tabline'.setup {
                enable = true,
                options = {
                    max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
                    show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
                    show_devicons = true, -- this shows devicons in buffer section
                    show_bufnr = false, -- this appends [bufnr] to buffer section,
                    show_filename_only = false, -- shows base filename only instead of relative path in filename
                }
            }
            vim.cmd[[
            set guioptions-=e " Use showtabline in gui vim
            set sessionoptions+=tabpages,globals " store tabpages and globals in session
            ]]
            vim.api.nvim_set_keymap("n", "<A-]>", "<cmd>TablineBufferNext<cr>", {silent = true, noremap = true})
            vim.api.nvim_set_keymap("n", "<A-[>", "<cmd>TablineBufferPrevious<cr>", {silent = true, noremap = true})
            vim.api.nvim_set_keymap("n", "<A-w>", "<cmd>bd<cr>", {silent = true, noremap = true})
        end,
        requires = { { 'hoob3rt/lualine.nvim', opt=true }, {'kyazdani42/nvim-web-devicons', opt = true} }
}
    --}}}

    ---- BOOTSTRAP {{{
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
    -- }}} THIS HAS TO BE THE LAST LINE
end)

-- Plugins to check out:
-- https://github.com/wellle/targets.vim-move
-- https://github.com/ThePrimeagen/harpoon
