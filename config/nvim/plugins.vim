" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.config/nvim/plugged')

" === Foundation ===
Plug 'nvim-lua/plenary.nvim'                                " Common Lua modules
Plug 'nvim-lua/popup.nvim'

"" === Navigation === "
Plug 'ibhagwan/fzf-lua'                                     " Improved fzf.vim written in lua
Plug 'vijaymarupudi/nvim-fzf'                               " A Lua API for using fzf in neovim. (depends by fzf-lua)
Plug 'nvim-telescope/telescope.nvim'                        " Find, filter, preview, pick
Plug 'ggandor/lightspeed.nvim'                              " Next-generation motion plugin with incremental input processing
Plug 'chentau/marks.nvim'                                   " viewing and interacting with Vim marks

"" === Git Plugins === "
Plug 'tpope/vim-fugitive'                                   " Enable git changes to be shown in sign column
Plug 'lewis6991/gitsigns.nvim'                               " Git signs written in pure lua
Plug 'kdheepak/lazygit.nvim'                                " calling lazygit within neovim

"" === Language support === "
"" --- general language parser and lsp ---
function! s:TreesitterHook(_)
    TSUpdate
    TSInstall all
endfunction
let TreesitterHookRef = function('s:TreesitterHook')
Plug 'nvim-treesitter/nvim-treesitter', { 'do': TreesitterHookRef } " Nvim Treesitter configurations and abstraction layer
Plug 'nvim-treesitter/nvim-treesitter-textobjects'                  " Create your own textobjects using tree-sitter queries
Plug 'nvim-treesitter/playground', {'on': 'TSPlaygroundToggle'}     " Debug tree-sitter
Plug 'neovim/nvim-lspconfig'                                        " Quickstart configurations for the Nvim LSP client
Plug 'ray-x/lsp_signature.nvim'                                     " LSP signature hint as you type
Plug 'jubnzv/virtual-types.nvim'                                    " shows type annotations as virtual text
"" --- debug ---
"Plug 'mfussenegger/nvim-dap'
"Plug 'rcarriga/nvim-dap-ui'
"Plug 'theHamsta/nvim-dap-virtual-text'
"" --- go ---
Plug 'ray-x/go.nvim'                                                " Go Neovim plugin, based on nvim-lsp, treesitter and Dap
"" --- rust ---
Plug 'simrat39/rust-tools.nvim'                                     " Battery-included rust lsp setup
Plug 'nvim-lua/lsp_extensions.nvim', {'for': 'rust'}                " LSP extensions

" === Editing Plugins === "
Plug 'ntpeters/vim-better-whitespace'                       " Trailing whitespace highlighting & automatic fixing
Plug 'hrsh7th/nvim-cmp'                                     " Auto completion Lua plugin for nvim
"nvim-cmp completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'                                    " Snippet plugin for vim/nvim that supports LSP/VSCode's snippet format.
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'windwp/nvim-autopairs'                                " autopairs for neovim written by lua
Plug 'windwp/nvim-spectre'                                  " Search and replace
Plug 'folke/which-key.nvim'                                 " displays a popup with possible keybindings of the command you started typing

" https://github.com/NixOS/nixpkgs/pull/129543
Plug 'romgrk/nvim-treesitter-context'                       " Show code context (show function if scrolled beyond screen)
Plug 'lukas-reineke/indent-blankline.nvim'                  " Indent guides for Neovim
Plug 'simrat39/symbols-outline.nvim'                        " A tree like view for symbols in Neovim using the Language Server Protocol
"Plug 'stevearc/aerial.nvim'
Plug 'norcalli/nvim-colorizer.lua'                          " Neovim colorizer
Plug 'numToStr/Comment.nvim'                                " comment plugin

"" === UI === "
Plug 'projekt0n/github-nvim-theme'                          " Github theme with treesitter support
Plug 'z11i/gruvbox-material'                                " Gruvbox with Material Palette and treesitter support (forked from sainnhe/gruvbox-material)
Plug 'sainnhe/sonokai'
Plug 'kyazdani42/nvim-web-devicons'                         " for file icons
Plug 'kyazdani42/nvim-tree.lua'                             " File explorer
Plug 'kevinhwang91/nvim-bqf'                                " Better quickfix window in Neovim
Plug 'nvim-lualine/lualine.nvim'                            " statusline plugin
"Plug 'https://github.com/adelarsq/neoline.vim'              " Status Line for Neovim focused on beauty and performance
Plug 'arkav/lualine-lsp-progress'                           " LSP Progress lualine componenet
Plug 'romgrk/barbar.nvim'                                   " tabline plugin
Plug 'numtostr/FTerm.nvim'                                  " floating terminal

" Initialize plugin system
call plug#end()
