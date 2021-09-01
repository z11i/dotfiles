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

" === Editing Plugins === "
Plug 'ntpeters/vim-better-whitespace'                       " Trailing whitespace highlighting & automatic fixing
Plug 'Shougo/echodoc.vim'                                   " Print function signatures in echo area
Plug 'hrsh7th/nvim-compe'                                   " Auto completion Lua plugin for nvim
Plug 'windwp/nvim-autopairs'                                " autopairs for neovim written by lua

"" === Navigation === "
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'

"" === Git Plugins === "
Plug 'mhinz/vim-signify'                                    " Enable git changes to be shown in sign column
Plug 'tpope/vim-fugitive'                                   " Enable git changes to be shown in sign column

"" === Language support === "
function! s:TreesitterHook(_)
    TSUpdate
    TSInstall go
    TSInstall gomod
endfunction
let TreesitterHookRef = function('s:TreesitterHook')
Plug 'nvim-treesitter/nvim-treesitter', { 'do': TreesitterHookRef } " Nvim Treesitter configurations and abstraction layer
Plug 'nvim-treesitter/nvim-treesitter-textobjects'                  " Create your own textobjects using tree-sitter queries
Plug 'neovim/nvim-lspconfig'                                        " Quickstart configurations for the Nvim LSP client
Plug 'ray-x/go.nvim'                                                " Go Neovim plugin, based on nvim-lsp, treesitter and Dap

"" === UI === "
Plug 'projekt0n/github-nvim-theme'                          " Github theme with treesitter support
Plug 'wojciechkepka/vim-github-dark'                        " Colorscheme
Plug 'vim-airline/vim-airline'                              " Customized vim status line

" Initialize plugin system
call plug#end()
