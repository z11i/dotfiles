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

" === Editing Plugins === "
Plug 'ntpeters/vim-better-whitespace'                       " Trailing whitespace highlighting & automatic fixing
Plug 'hrsh7th/nvim-compe'                                   " Auto completion Lua plugin for nvim
Plug 'windwp/nvim-autopairs'                                " autopairs for neovim written by lua
Plug 'windwp/nvim-spectre'                                  " Search and replace
Plug 'folke/which-key.nvim'                                 " displays a popup with possible keybindings of the command you started typing
Plug 'romgrk/nvim-treesitter-context'                       " Show code context (show function if scrolled beyond screen)
Plug 'lukas-reineke/indent-blankline.nvim'                  " Indent guides for Neovim

"" === Navigation === "
Plug 'ibhagwan/fzf-lua'                                     " Improved fzf.vim written in lua
Plug 'vijaymarupudi/nvim-fzf'                               " A Lua API for using fzf in neovim.
"Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }
"Plug 'ray-x/navigator.lua'                                  " Easy code navigation, view diagnostic errors, see relationships of functions, variables

"" === Git Plugins === "
Plug 'tpope/vim-fugitive'                                   " Enable git changes to be shown in sign column
Plug 'lewis6991/gitsigns.nvim'                               " Git signs written in pure lua

"" === Language support === "
function! s:TreesitterHook(_)
    TSUpdate
    TSInstall go
    TSInstall gomod
endfunction
let TreesitterHookRef = function('s:TreesitterHook')
Plug 'nvim-treesitter/nvim-treesitter', { 'do': TreesitterHookRef } " Nvim Treesitter configurations and abstraction layer
Plug 'nvim-treesitter/nvim-treesitter-textobjects'                  " Create your own textobjects using tree-sitter queries
Plug 'nvim-treesitter/playground', {'on': 'TSPlaygroundToggle'}     " Debug tree-sitter
Plug 'neovim/nvim-lspconfig'                                        " Quickstart configurations for the Nvim LSP client
Plug 'ray-x/go.nvim'                                                " Go Neovim plugin, based on nvim-lsp, treesitter and Dap

"" === UI === "
Plug 'projekt0n/github-nvim-theme'                          " Github theme with treesitter support
Plug 'z11i/gruvbox-material'                                " Gruvbox with Material Palette and treesitter support (forked from sainnhe/gruvbox-material)"
Plug 'kyazdani42/nvim-web-devicons'                         " for file icons
Plug 'kyazdani42/nvim-tree.lua'                             " File explorer
Plug 'kevinhwang91/nvim-bqf'                                " Better quickfix window in Neovim
Plug 'hoob3rt/lualine.nvim'                                 " statusline plugin
Plug 'jose-elias-alvarez/buftabline.nvim'                   " bufferline"
Plug 'numtostr/FTerm.nvim'                                  " floating terminal

" Initialize plugin system
call plug#end()
