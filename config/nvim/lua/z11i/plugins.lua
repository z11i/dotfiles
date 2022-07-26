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

local navigation = function(use)
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
                        vertical = {
                            height = 0.7,
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
            vim.cmd [[nnoremap <Leader>f :Telescope find_files<CR>]]
            vim.cmd [[nnoremap <Leader>F :Telescope find_files hidden=true no_ignore=true<CR>]]
            vim.cmd [[nnoremap <Leader>/ :Telescope live_grep<CR>]]
            vim.cmd [[nnoremap <Leader>? :lua require('telescope.builtin').live_grep({vimgrep_arguments={'rg','--color=never','--no-heading','--column','-HS', '-uu'}})<CR>]]
            vim.cmd [[nnoremap <Leader>H :Telescope oldfiles only_cwd=true<CR>]]
            vim.cmd [[nnoremap <Leader>b :Telescope buffers<CR>]]
            vim.cmd [[nnoremap <Leader>s :Telescope lsp_document_symbols<CR>]]
            vim.cmd [[nnoremap <Leader>S :Telescope lsp_dynamic_workspace_symbols<CR>]]
            vim.cmd [[nnoremap <Leader>ta :Telescope commands<CR>]]
            vim.cmd [[nnoremap <Leader>tr :Telescope lsp_references<CR>]]
            vim.cmd [[nnoremap <Leader>tt :Telescope lsp_type_definitions<CR>]]
            vim.cmd [[nnoremap <Leader>ti :Telescope lsp_implementations<CR>]]
            vim.cmd [[nnoremap <Leader>tg :Telescope grep_string<CR>]]
            vim.cmd [[nnoremap <Leader>gc :Telescope git_commits theme=ivy<CR>]]
            vim.cmd [[nnoremap <Leader>gb :Telescope git_bcommits theme=ivy<CR>]]
            vim.cmd [[nnoremap <Leader>gs :Telescope git_status theme=ivy<CR>]]
            vim.cmd [[nnoremap <Leader>gb :Telescope git_branches theme=ivy<CR>]]
            vim.cmd [[nnoremap <Leader>r :Telescope resume<CR>]]
        end,
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-fzf-native.nvim', run = {'make'} },
        }
    }
    -- Lightspeed: motion and jump to location
    use {
        'ggandor/lightspeed.nvim',
        --disable = true, -- replaced by pounce
        config = function()
            vim.g.lightspeed_no_default_keymaps = true
            require('lightspeed').setup({
                exit_after_idle_msecs = { labeled = nil, unlabeled = nil },
                ignore_case = true,
            })
            -- Use ; as : for easier command typing
            vim.cmd [[nnoremap ; :]]
            -- vim.cmd [[nnoremap : :!]]
            vim.cmd [[nmap \ <Plug>Lightspeed_omni_s]]
            vim.cmd [[vmap \ <Plug>Lightspeed_omni_s]]
            vim.cmd [[omap \ <Plug>Lightspeed_omni_s]]
            vim.cmd [[nmap f <Plug>Lightspeed_f]]
            vim.cmd [[vmap f <Plug>Lightspeed_f]]
            vim.cmd [[omap f <Plug>Lightspeed_f]]
            vim.cmd [[nmap F <Plug>Lightspeed_F]]
            vim.cmd [[vmap F <Plug>Lightspeed_F]]
            vim.cmd [[omap F <Plug>Lightspeed_F]]
            vim.cmd [[nmap t <Plug>Lightspeed_t]]
            vim.cmd [[vmap t <Plug>Lightspeed_t]]
            vim.cmd [[omap t <Plug>Lightspeed_t]]
            vim.cmd [[nmap T <Plug>Lightspeed_T]]
            vim.cmd [[vmap T <Plug>Lightspeed_T]]
            vim.cmd [[omap T <Plug>Lightspeed_T]]
        end,
        requires = { {'tpope/vim-repeat', opt = true} }
    }
    -- Incremental fuzzy search motion plugin
    use {
        'rlane/pounce.nvim',
        disable = true,
        config = function()
            vim.cmd [[nmap \ <Cmd>Pounce<CR>]]
            vim.cmd [[vmap \ <Cmd>Pounce<CR>]]
            vim.cmd [[omap \ <Cmd>Pounce<CR>]]
        end,
    }
    use { -- Neovim plugin to manage the file system and other tree like structures.
        "nvim-neo-tree/neo-tree.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function ()
            -- Unless you are still migrating, remove the deprecated commands from v1.x
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
            function dump(o)
                if type(o) == 'table' then
                    local s = '{ '
                    for k,v in pairs(o) do
                        if type(k) ~= 'number' then k = '"'..k..'"' end
                        s = s .. '['..k..'] = ' .. dump(v) .. ','
                    end
                    return s .. '} '
                else
                    return tostring(o)
                end
            end

            require("neo-tree").setup({
                close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = true,
                sort_case_insensitive = false, -- used when sorting files and directories in the tree
                sort_function = function(a, b) -- use a custom function for sorting files and directories in the tree

                    if a.type == b.type then
                        return a.path < b.path
                    else
                        return a.type < b.type
                    end
                end,
                default_component_configs = {
                    container = {
                        enable_character_fade = true
                    },
                    indent = {
                        indent_size = 2,
                        padding = 1, -- extra padding on left hand side
                        -- indent guides
                        with_markers = true,
                        indent_marker = "│",
                        last_indent_marker = "└",
                        highlight = "NeoTreeIndentMarker",
                        -- expander config, needed for nesting files
                        with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                        expander_collapsed = "",
                        expander_expanded = "",
                        expander_highlight = "NeoTreeExpander",
                    },
                    icon = {
                        folder_closed = "",
                        folder_open = "",
                        folder_empty = "ﰊ",
                        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                        -- then these will never be used.
                        default = "*",
                        highlight = "NeoTreeFileIcon"
                    },
                    modified = {
                        symbol = "[+]",
                        highlight = "NeoTreeModified",
                    },
                    name = {
                        trailing_slash = false,
                        use_git_status_colors = true,
                        highlight = "NeoTreeFileName",
                    },
                    git_status = {
                        symbols = {
                            -- Change type
                            added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                            modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                            deleted   = "✖",-- this can only be used in the git_status source
                            renamed   = "",-- this can only be used in the git_status source
                            -- Status type
                            untracked = "",
                            ignored   = "",
                            unstaged  = "",
                            staged    = "",
                            conflict  = "",
                        }
                    },
                },
                window = {
                    position = "right",
                    width = 40,
                    mapping_options = {
                        noremap = true,
                        nowait = true,
                    },
                    mappings = {
                        ["<space>"] = false,
                        ["<2-LeftMouse>"] = "open",
                        ["<cr>"] = "open",
                        ["S"] = "open_split",
                        ["s"] = "open_vsplit",
                        -- ["S"] = "split_with_window_picker",
                        -- ["s"] = "vsplit_with_window_picker",
                        ["t"] = "open_tabnew",
                        ["w"] = "open_with_window_picker",
                        ["C"] = "close_node",
                        ["z"] = "close_all_nodes",
                        --["Z"] = "expand_all_nodes",
                        ["a"] = {
                            "add",
                            -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                            config = {
                                show_path = "none" -- "none", "relative", "absolute"
                            }
                        },
                        ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
                        ["d"] = "delete",
                        ["r"] = "rename",
                        ["y"] = "copy_to_clipboard",
                        ["x"] = "cut_to_clipboard",
                        ["p"] = "paste_from_clipboard",
                        ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
                        -- ["c"] = {
                        --  "copy",
                        --  config = {
                        --    show_path = "none" -- "none", "relative", "absolute"
                        --  }
                        --}
                        ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
                        ["q"] = "close_window",
                        ["R"] = "refresh",
                        ["?"] = "show_help",
                    }
                },
                nesting_rules = {},
                filesystem = {
                    filtered_items = {
                        visible = false, -- when true, they will just be displayed differently than normal items
                        hide_dotfiles = false,
                        hide_gitignored = false,
                        hide_hidden = true, -- only works on Windows for hidden files/directories
                        hide_by_name = {
                            --"node_modules"
                        },
                        hide_by_pattern = { -- uses glob style patterns
                            --"*.meta"
                        },
                        never_show = { -- remains hidden even if visible is toggled to true
                            ".DS_Store",
                            --"thumbs.db"
                        },
                    },
                    follow_current_file = true, -- This will find and focus the file in the active buffer every
                    -- time the current file is changed while the tree is open.
                    group_empty_dirs = false, -- when true, empty folders will be grouped together
                    hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                    -- in whatever position is specified in window.position
                    -- "open_current",  -- netrw disabled, opening a directory opens within the
                    -- window like netrw would, regardless of window.position
                    -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
                    use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                    -- instead of relying on nvim autocmd events.
                    window = {
                        mappings = {
                            ["<bs>"] = "navigate_up",
                            ["."] = "set_root",
                            ["H"] = "toggle_hidden",
                            ["/"] = "fuzzy_finder",
                            ["D"] = "fuzzy_finder_directory",
                            ["f"] = "filter_on_submit",
                            ["<c-x>"] = "clear_filter",
                            ["[g"] = "prev_git_modified",
                            ["]g"] = "next_git_modified",
                        }
                    }
                },
                buffers = {
                    follow_current_file = true, -- This will find and focus the file in the active buffer every
                    -- time the current file is changed while the tree is open.
                    group_empty_dirs = true, -- when true, empty folders will be grouped together
                    show_unloaded = true,
                    window = {
                        mappings = {
                            ["bd"] = "buffer_delete",
                            ["<bs>"] = "navigate_up",
                            ["."] = "set_root",
                        }
                    },
                },
                git_status = {
                    window = {
                        position = "float",
                        mappings = {
                            ["A"]  = "git_add_all",
                            ["gu"] = "git_unstage_file",
                            ["ga"] = "git_add_file",
                            ["gr"] = "git_revert_file",
                            ["gc"] = "git_commit",
                            ["gp"] = "git_push",
                            ["gg"] = "git_commit_and_push",
                        }
                    }
                }
            })
        end
    }
    use {
        'ThePrimeagen/harpoon',
        disable = true,
        requires = {
            {'nvim-telescope/telescope.nvim'},
            {'nvim-lua/plenary.nvim'},
        },
        config = function()
            require('telescope').load_extension('harpoon')
            vim.cmd [[nnoremap <Leader>hh :lua require('harpoon.ui').toggle_quick_menu()<CR>]]
            vim.cmd [[nnoremap <Leader>h] :lua require('harpoon.ui').nav_next()<CR>]]
            vim.cmd [[nnoremap <Leader>h[ :lua require('harpoon.ui').nav_prev()<CR>]]
            vim.cmd [[nnoremap <Leader>ha :lua require('harpoon.mark').add_file()<CR>]]

            vim.cmd [[nnoremap <Leader>h1 :lua require('harpoon.ui').nav_file(1)<CR>]]
            vim.cmd [[nnoremap <Leader>h2 :lua require('harpoon.ui').nav_file(2)<CR>]]
            vim.cmd [[nnoremap <Leader>h3 :lua require('harpoon.ui').nav_file(3)<CR>]]
            vim.cmd [[nnoremap <Leader>h4 :lua require('harpoon.ui').nav_file(4)<CR>]]
            vim.cmd [[nnoremap <Leader>h5 :lua require('harpoon.ui').nav_file(5)<CR>]]
            vim.cmd [[nnoremap <Leader>h6 :lua require('harpoon.ui').nav_file(6)<CR>]]
            vim.cmd [[nnoremap <Leader>h7 :lua require('harpoon.ui').nav_file(7)<CR>]]
            vim.cmd [[nnoremap <Leader>h8 :lua require('harpoon.ui').nav_file(8)<CR>]]
            vim.cmd [[nnoremap <Leader>h9 :lua require('harpoon.ui').nav_file(9)<CR>]]
        end,
    }
    -- manage multiple terminal windows
    use {"akinsho/toggleterm.nvim", config = function()
        require'toggleterm'.setup{
            direction = 'horizontal',
            hide_numbers = true,
            open_mapping = nil,
            shell = 'fish',
            start_in_insert = true,
        }
        vim.cmd [[nnoremap <F12> <cmd>ToggleTerm<cr>]]
        vim.cmd [[nnoremap <Esc><F12> <cmd>ToggleTermToggleAll<cr>]]
        vim.cmd [[tnoremap <F12> <C-\><C-n><cmd>ToggleTerm<cr>]]
        vim.cmd [[nnoremap 1<F12> <cmd>1ToggleTerm<cr>]]
        vim.cmd [[nnoremap 2<F12> <cmd>2ToggleTerm<cr>]]
        vim.cmd [[nnoremap 3<F12> <cmd>3ToggleTerm<cr>]]
        vim.cmd [[nnoremap 4<F12> <cmd>4ToggleTerm<cr>]]
        vim.cmd [[nnoremap 5<F12> <cmd>5ToggleTerm<cr>]]
        vim.cmd [[nnoremap 6<F12> <cmd>6ToggleTerm<cr>]]
        vim.cmd [[nnoremap 7<F12> <cmd>7ToggleTerm<cr>]]
        vim.cmd [[nnoremap 8<F12> <cmd>8ToggleTerm<cr>]]
        vim.cmd [[nnoremap 9<F12> <cmd>9ToggleTerm<cr>]]

        local Terminal  = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            direction = "float",
            -- function to run on opening the terminal
            on_open = function(term)
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
            end,
            -- function to run on closing the terminal
            on_close = function(term)
                vim.cmd("Closing terminal")
            end,
        })
        function _lazygit_toggle() lazygit:toggle() end
        vim.cmd [[nnoremap <Leader>gg <cmd>lua _lazygit_toggle()<cr>]]
    end}
end

local treesitter = function(use)
    ---- Treesitter {{{
    use { 'nvim-treesitter/nvim-treesitter', run = {':TSUpdate', ':TSInstall all'} }
    -- Create your own textobjects using tree-sitter queries
    use {'nvim-treesitter/nvim-treesitter-textobjects'}
    -- Debug tree-sitter
    use {'nvim-treesitter/playground', opt = true, cmd = 'TSPlaygroundToggle'}
    -- Show code context (show function if scrolled beyond screen)
    use {'lewis6991/nvim-treesitter-context', config = function()
        require'treesitter-context'.setup{ enable = true, throttle = true }
    end}
    --}}}
end

local lsp = function(use)
    ---- LSP plugins {{{
    -- Quickstart configurations for the Nvim LSP client
    use {'neovim/nvim-lspconfig',
        requires = {
            {'ray-x/lsp_signature.nvim'},  -- LSP signature hint as you type
            {'jubnzv/virtual-types.nvim'}, -- shows type annotations as virtual text
        },
    }
    -- Go Neovim plugin, based on nvim-lsp, treesitter and Dap
    use {
        'ray-x/go.nvim',
        ft = {'go', 'gomod'},
        disable = false,
        requires = {
            {'neovim/nvim-lspconfig'},
            {'mfussenegger/nvim-dap'},
            {'rcarriga/nvim-dap-ui'},
            {'theHamsta/nvim-dap-virtual-text'},
        },
        config = function()
            vim.opt.expandtab = false
            vim.opt.shiftwidth=4
            vim.opt.softtabstop=4
            vim.opt.tabstop=4

            vim.cmd [[autocmd BufWritePre *.go :lua require('go.format').goimport()]]

            require('go').setup({
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
        end,
    }
    -- Go development plugin for Vim
    use {
        'fatih/vim-go',
        disable = true,
    }
    use {
        'crispgm/nvim-go',
        disable = true,
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
            'neovim/nvim-lspconfig',
        }
    }
    -- Battery-included rust lsp setup
    use {
        'simrat39/rust-tools.nvim',
        config = function() require('z11i/rust-tools') end,
        requires = {
            {'neovim/nvim-lspconfig'},
            {'jubnzv/virtual-types.nvim'},-- shows type annotations as virtual text
        }}
    -- LSP extensions
    use {'nvim-lua/lsp_extensions.nvim',
        config = function()
            vim.cmd [[ autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{} ]]
        end,
        ft = {'rs'},
        requires = {{'neovim/nvim-lspconfig'}}}
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
    -- standalone ui for nvim-lsp progress
    use { 'j-hui/fidget.nvim', config = function() require('fidget').setup() end }
    --}}}
end

local debugging = function(use)
    ---- Debugging {{{
    use {
        'mfussenegger/nvim-dap',
        requires = {
            {'Pocco81/DAPInstall.nvim'},
            {'rcarriga/nvim-dap-ui'},
            {'theHamsta/nvim-dap-virtual-text'},
        },
        config = function()
            vim.api.nvim_set_keymap("n", "<Leader>du",  "<cmd>lua require('dapui').toggle()<CR>", {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<Leader>db",  "<cmd>lua require('dap').toggle_breakpoint()<CR>", {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<Leader>dc",  "<cmd>lua require('dap').continue()<CR>", {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<F8>",        "<cmd>lua require('dap').step_over()<CR>", {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<F7>",        "<cmd>lua require('dap').step_into()<CR>", {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<F9>",        "<cmd>lua require('dap').step_out()<CR>", {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<Leader>dhh", "<cmd>lua require('dap.ui.variables').hover()<CR>", {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<Leader>dhv", "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<Leader>dwh", "<cmd>lua require('dap.ui.widgets').hover()<CR>", {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<Leader>dwf", "<cmd>lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<Leader>dro", "<cmd>lua require('dap').repl.open()<CR>", {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<Leader>drl", "<cmd>lua require('dap').repl.run_last()<CR>", {noremap = true, silent = true})
        end,
    }
    --}}}
end

local git = function(use)
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
end

local editing = function(use)
    ---- EDITING {{{
    -- Copilot
    use {
        'github/copilot.vim', config = function()
            vim.g.copilot_filetypes = { xml = false, TelescopePrompt = false }
        end,
        disable = true,
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
                    -- https://www.reddit.com/r/neovim/comments/u7nsje/comment/i5fv73j
                    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
                    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
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
        'chentoast/marks.nvim',
        config = function()
            require'marks'.setup {
                refresh_interval = 150,
                excluded_filetypes = {},
                mappings = {}
            }
        end,
    }
    -- Trailing whitespace highlighting & automatic fixing
    -- use { 'ntpeters/vim-better-whitespace' }

    -- Automatically strip trailing whitespace as you are editing.
    use {
        'lewis6991/spaceless.nvim',
        config = function()
            require'spaceless'.setup()
        end
    }
    --}}}
end

local testing = function(use)
    ---- Testing {{{
    use {'vim-test/vim-test'}
    use {'sebdah/vim-delve'}
    --}}}
end

local theming = function(use)
    ---- THEME plugins {{{
    -- use {
    --     'rebelot/kanagawa.nvim',
    --     config = function() require('z11i/theme/kanagawa') end,
    -- }
    use {
        "catppuccin/nvim", as = "catppuccin",
        config = function() require('z11i/theme/catppuccin') end,
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
        config = function()
            require'lualine'.setup {
                options = {
                    icons_enabled = true,
                    theme = "catppuccin",
                    section_separators = { left = '', right = ''},
                    component_separators = { left = '', right = ''},
                    disabled_filetypes = {'aerial'},
                    globalstatus = true,
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff'},
                    lualine_c = {
                        {'filename', file_status = true, path = 1},
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
                    max_bufferline_percent = 100, -- set to nil by default, and it uses vim.o.columns * 2/3
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
            vim.api.nvim_set_keymap("n", "<A-w>", "<cmd>bdelete<cr>", {silent = true, noremap = true})
        end,
        requires = { { 'hoob3rt/lualine.nvim', opt=true }, {'kyazdani42/nvim-web-devicons', opt = true} }
    }
    --}}}
end

local tryout = function(use)
    use { 'tpope/vim-abolish' }
    use({
        "gbprod/substitute.nvim",
        config = function()
            require("substitute").setup({
                on_substitute = nil,
                yank_substituted_text = false,
                range = {
                    prefix = "S",
                    prompt_current_text = false,
                    confirm = true,
                    complete_word = false,
                    motion1 = false,
                    motion2 = false,
                    suffix = "",
                },
                exchange = {
                    motion = false,
                },
            })
            vim.keymap.set("n", "<C-s>", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
            vim.keymap.set("n", "<C-s><C-s>", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
            vim.keymap.set("n", "<C-c>", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
            vim.keymap.set("x", "<C-s>", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })

            vim.keymap.set("n", "<leader><C-s>", "<cmd>lua require('substitute.range').operator()<cr>", { noremap = true })
            vim.keymap.set("x", "<leader><C-s>", "<cmd>lua require('substitute.range').visual()<cr>", { noremap = true })
            vim.keymap.set("n", "<leader><C-s><C-s>", "<cmd>lua require('substitute.range').word()<cr>", { noremap = true })
        end
})
end

return require('packer').startup(function(use)
    use {
        'wbthomason/packer.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-lua/popup.nvim'},
        },
    }

    use 'lewis6991/impatient.nvim'

    use {
        'antoinemadec/FixCursorHold.nvim', -- Fix CursorHold Performance: https://github.com/neovim/neovim/issues/12587
        config = function()
            vim.g.cursorhold_updatetime = 300
        end,
    }

    navigation(use)

    treesitter(use)

    lsp(use)

    debugging(use)

    git(use)

    editing(use)

    testing(use)

    theming(use)

    tryout(use)

    ---- BOOTSTRAP {{{
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
    -- }}} THIS HAS TO BE THE LAST LINE
end)

