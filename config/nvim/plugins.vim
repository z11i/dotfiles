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
Plug 'christoomey/vim-tmux-navigator'                       " Tmux/Neovim movement integration
Plug 'Shougo/denite.nvim'                                   " Denite - Fuzzy finding, buffer management
Plug 'Shougo/echodoc.vim'                                   " Print function signatures in echo area

"" === Navigation === "
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

"" === Git Plugins === "
Plug 'mhinz/vim-signify'                                    " Enable git changes to be shown in sign column
Plug 'tpope/vim-fugitive'                                   " Enable git changes to be shown in sign column

"" === Language support === "
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }          " Go development plugin for Vim
"
"" === UI === "
Plug 'scrooloose/nerdtree'                                  " File explorer
Plug 'ayu-theme/ayu-vim'                                    " Colorscheme
Plug 'vim-airline/vim-airline'                              " Customized vim status line

" Initialize plugin system
call plug#end()
