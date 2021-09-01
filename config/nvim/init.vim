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
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete_delay', 10)
call deoplete#custom#option('auto_refresh_delay', 50)

" instructs deoplete to use omni completion for go files
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

" <TAB>: completion.
" https://stackoverflow.com/a/44271350
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

""""" Search -----------------------------------------------------------------
" fzf
nnoremap <silent> <Leader>g :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
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
""" Go
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_debug = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1

let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:go_doc_popup_window = 1
let g:go_doc_balloon = 0

" show type information in the status line
let g:go_auto_type_info = 1
let g:go_updatetime = 500 " reduce time delay for jobs like go_auto_type_info

" map commands
let g:go_def_mapping_enabled = 0 " disable default gd mapping
let g:go_def_reuse_buffer = 1
au FileType go nmap <C-]> <Plug>(go-def)
au FileType go nmap gd <Plug>(go-def-vertical)
au FileType go nmap gD <Plug>(go-def-split)
au FileType go nmap gt <Plug>(go-def-type-vertical)
au FileType go nmap gT <Plug>(go-def-type-split)
au FileType go nmap g] <Plug>(go-def-type)
au FileType go nmap gr <Plug>(go-referrers)
au FileType go nmap gi <Plug>(go-implements)

au FileType go nnoremap gl :GoDecls
au FileType go nnoremap gL :GoDeclsDir
au FileType go nnoremap gotf :GoTestFunc

" add json tags in snakecase
let g:go_addtags_transform = "snakecase"


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
    colorscheme ghdark
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
let g:airline_theme='ghdark'

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

