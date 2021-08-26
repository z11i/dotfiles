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

" === netrw (default vim explorer) ==== "
" https://shapeshed.com/vim-netrw/
let g:netrw_banner = 0 "remove banner
let g:netrw_browse_split = 4 "preview when opening files
let g:netrw_winsize = 15 "window size
let g:netrw_liststyle = 3 "tree style listing
let g:netrw_altv = 1
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END


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

""""" Search -----------------------------------------------------------------
" fzf
nnoremap <silent> <Leader><C-g> :Files<CR>
nnoremap <silent> <Leader><C-f> :Rg<CR>
nnoremap <silent> <Leader><C-e> :History<CR>

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
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

" show type information in the status line
let g:go_auto_type_info = 1

" map go-def
au FileType go nnoremap <Leader>gd <Plug>(go-def)
au FileType go nnoremap <Leader>gt <Plug>(go-def-type)
au FileType go nnoremap <Leader>gr <Plug>(go-referrers)

" add json tags in snakecase
let g:go_addtags_transform = "snakecase"


""""" Aesthetics -------------------------------------------------------------
set background=dark
set termguicolors
set cursorline

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

" powerline symbols
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
let g:airline#extensions#tabline#enabled = 1
let g:airline_extensions = ['branch', 'hunks', 'coc']

" Update section z to just have line number
"let g:airline_section_z = airline#section#create(['linenr'])

" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'

let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

" Configure error/warning section to use coc.nvim
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),1)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

