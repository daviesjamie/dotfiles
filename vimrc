" Don't try to be compatible with vi
set nocompatible

" PLUGINS ----------------------------------------------------------------- {{{

" Automatically install vim-plug if it's not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'daviesjamie/vim-base16-lightline'
Plug 'godlygeek/tabular'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

call plug#end()

" }}}
" GENERAL ----------------------------------------------------------------- {{{

set autoindent          " automatically indent new lines
set autoread            " re-read an open file that has changed outside vim
set cursorline          " highlght the line the cursor is on
set display=lastline    " display as much as possible of a long last line
set encoding=utf-8      " use utf-8 character set by default
set expandtab           " use spaces instead of \t
set formatoptions=q     " allow formatting of comments with gq
set formatoptions+=n    " recognise numbered lists when formatting
set formatoptions+=1    " don't break lines after a one-letter word
set formatoptions+=l    " don't automatically format/wrap already too-long lines
set hidden              " allow unsaved buffers to exist in the background
set hlsearch            " highlight search matches
set ignorecase          " search patterns are case-insensitive
set incsearch           " search incrementally as you type
set notimeout           " timeout on keycodes, but not mappings
set number              " use line numbers
set scrolloff=5         " keep 5 lines visible above/below cursor (if possible)
set shiftround          " when shifting, always use a multiple of shiftwidth
set shiftwidth=4        " set size of an 'indent' to 4 spaces
set showcmd             " display incomplete commands at the bottom
set showmatch           " show matching brackets
set smartcase           " automatically decide to search with case or not
set smarttab            " make adding/removing tabs (spaces) smarter
set softtabstop=4       " set soft tabstop size to 4
set spelllang=en_gb     " set spelling to use British English
set splitbelow          " always make new splits below, not above
set splitright          " always make new splits on the right, not on the left
set synmaxcol=800       " don't syntax-highlight long lines
set tabstop=4           " set hard tabstop size to 4
set title               " update the terminal title with filename
set ttimeout
set ttimeoutlen=10      " wait 10ms for a keycode to complete
set ttyfast             " use a fast terminal connection
set wildmenu            " use a menu for command-line completion

" Backspace over everything in insert mode
set backspace=indent,eol,start

" Enable filetype detection/plugins
filetype plugin indent on

" Remove comment markup when joining lines
if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j
endif

" Set invisible (list) characters
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮

" Viminfo settings:
"   !  Save and restore global variables starting with an uppercase letter
" '20  Remember marks for 20 most recent files
" <50  Save 50 lines for each register
" s10  Save a maximum of 10kb for each item
"   h  Disable 'hlsearch' when loading viminfo
if v:version >= 700
    set viminfo=!,'20,<50,s10,h
endif

" On completion, complete longest common string and open wildmenu
set wildmode=longest:full,full

" }}}
" FILETYPE-SPECIFIC ------------------------------------------------------- {{{

if has('autocmd')
    " Filetype-specific settings
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType vim  setlocal foldmethod=marker

    " Override filetype for certain files
    autocmd BufNewFile,BufRead *.tt set filetype=html
endif

" }}}
" TEMPORARY FILES ---------------------------------------------------------- {{{

set history=1000                " keep 1000 lines of command line history
set undofile                    " save undo history to a file
set undoreload=10000            " save 10000 lines of undo history

set undodir=~/.vim/tmp/undo     " save undo files to ~/.vim/tmp/undo
set backupdir=~/.vim/tmp/backup " save backup files to ~/.vim/tmp/backup
set directory=~/.vim/tmp/swap   " save swap files to ~/.vim/tmp/swap

" Create temporary folders if they don't already exist
if !isdirectory( expand( &undodir ) )
    call mkdir( expand( &undodir ), "p" )
endif
if !isdirectory( expand( &backupdir ) )
    call mkdir( expand( &backupdir ), "p" )
endif
if !isdirectory( expand( &directory ) )
    call mkdir( expand( &directory ), "p" )
endif

" }}}
" KEY BINDINGS ------------------------------------------------------------ {{{

" Set leader key to space
let mapleader="\<Space>"

" Easier navigation between windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Make j and k work on screen lines, not file lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Toggle folds with double-space
nmap <leader><leader> za

" Use enter to toggle search highlighting
nmap <CR> :set hlsearch! hlsearch?<CR>

" }}}
" HOOKS ------------------------------------------------------------------- {{{

" Only show cursorline in the current window
augroup cline
    au!
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
augroup END

" Resize splits when the window is resized
au VimResized * :wincmd = 

" }}}
" COLOUR SCHEME ----------------------------------------------------------- {{{

" Allow base16 themes to use 256 colourspace
let base16colorspace=256

set background=dark
colorscheme base16-tomorrow

" }}}
" STATUS LINE ------------------------------------------------------------- {{{

" Always show the statusline
set laststatus=2

" Configure vim-lightline
let g:lightline = {
\     'colorscheme': 'base16',
\     'active' : {
\         'left':  [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
\         'right': [ [ 'lineinfo' ], [ 'filetype' ] ]
\     },
\     'inactive' : {
\         'left':  [ [ 'fugitive', 'filename' ] ],
\         'right': [ [ 'filetype' ] ]
\     },
\     'component_function': {
\         'mode':      'LLMode',
\         'readonly':  'LLReadonly',
\         'modified':  'LLModified',
\         'fugitive':  'LLFugitive',
\         'filename':  'LLFilename',
\         'ctrlpmark': 'CtrlPMark',
\     },
\     'separator': { 'left': '', 'right': '' },
\     'subseparator': { 'left': '', 'right': '' },
\     'mode_map': {
\         'n': 'N',
\         'i': 'I',
\         'R': 'R',
\         'v': 'V', 'V': 'V', "\<C-v>": 'V',
\         'c': 'C',
\         's': 'S', 'S': 'S', "\<C-s>": 'S',
\         't': 'T',
\         '?': ' ',
\    }
\ }

function! LLMode()
    let modewidth = strlen(lightline#mode()) + 2
    let linenowidth = strlen(line('$')) + 1
    let linenowidth = linenowidth > 4 ? linenowidth : 4
    return modewidth >= linenowidth ? lightline#mode()
         \ : repeat(' ', linenowidth - modewidth) . lightline#mode()
endfunction

function! LLReadonly()
    return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! LLModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LLFugitive()
    if exists('*fugitive#head')
        let head = fugitive#head(8)
        return strlen(head) ? ' ' . head : ''
    endif
    return ''
endfunction

function! LLFilename()
    if expand('%:t') == 'ControlP'
        return g:lightline.ctrlp_prev . ' ' . g:lightline.subseparator.left . ' '
             \ . g:lightline.ctrlp_item . ' ' . g:lightline.subseparator.left . ' '
             \ . g:lightline.ctrlp_next
    endif
    return ( LLReadonly() != '' ? LLReadonly() . ' ' : '' )
         \ . ( expand('%:t') != '' ? expand('%:t') : '[No Name]' )
         \ . ( LLModified() != '' ? ' ' . LLModified() : '')
endfunction

function! CtrlPMark()
    return expand('%:t') =~ 'ControlP' ? g:lightline.ctrlp_marked : ''
endfunction

let g:ctrlp_status_func = {
\    'main': 'CtrlPStatusFunc_1',
\    'prog': 'CtrlPStatusFunc_2',
\ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    let g:lightline.ctrlp_marked = a:marked
    return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
    return lightline#statusline(0)
endfunction

" }}}
