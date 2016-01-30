" GENERAL ----------------------------------------------------------------- {{{

" Don't try to be compatible with vi
set nocompatible

set autoindent          " automatically indent new lines
set autoread            " re-read an open file that has changed outside vim
set display=lastline    " display as much as possible of a long last line
set encoding=utf-8      " use utf-8 character set by default
set expandtab           " use spaces instead of \t
set formatoptions=q     " allow formatting of comments with gq
set formatoptions+=n    " recognise numbered lists when formatting
set formatoptions+=1    " don't break lines after a one-letter word
set formatoptions+=l    " don't automatically format/wrap already too-long lines
set hidden              " allow unsaved buffers to exist in the background
set hlsearch            " highlight search matches
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

" Remove comment markup when joining lines
if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j
endif

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
" PLUGINS ----------------------------------------------------------------- {{{

" Automatically install vim-plug if it's not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'

Plug 'itchyny/lightline.vim'

Plug 'tpope/vim-fugitive'

call plug#end()

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
\     'active' : {
\         'left':  [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
\         'right': [ [ 'lineinfo' ], [ 'filetype' ] ]
\     },
\     'inactive' : {
\         'left':  [ [ 'fugitive', 'filename' ] ],
\         'right': [ [ 'filetype' ] ]
\     },
\     'component_function': {
\         'mode'    : 'LLModeSized',
\         'readonly': 'LLReadonly',
\         'modified': 'LLModified',
\         'fugitive': 'LLFugitive',
\         'filename': 'LLFilename',
\     },
\ }

function! LLMode()
    return lightline#mode() == 'NORMAL' ? 'N' :
         \ lightline#mode() == 'INSERT' ? 'I' :
         \ lightline#mode() == 'VISUAL' ? 'V' :
         \ lightline#mode() == 'V-LINE' ? 'V' :
         \ lightline#mode() == 'V-BLOCK' ? 'V' :
         \ lightline#mode() == 'REPLACE' ? 'R' : lightline#mode()
endfunction

function! LLModeSized()
    let len_mode = strlen( LLMode() ) + 2
    let len_col  = strlen( line('$') ) + 1
    return !&number ? LLMode()
         \ : ( len_mode < len_col ? repeat(' ', len_col - len_mode) . LLMode()
         \   : LLMode() )
endfunction

function! LLReadonly()
    return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! LLModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LLFugitive()
    if exists('*fugitive#head')
        let head = fugitive#head()
        return strlen(head) ? ' ' . head : ''
    endif
    return ''
endfunction

function! LLFilename()
    return ( LLReadonly() != '' ? LLReadonly() . ' ' : '' )
         \ . ( expand('%:t') != '' ? expand('%:t') : '[No Name]' )
         \ . ( LLModified() != '' ? ' ' . LLModified() : '')
endfunction

" }}}
" KEY BINDINGS ------------------------------------------------------------ {{{

" Set leader key to space
let mapleader="\<Space>"

" Toggle folds with double-space
nmap <leader><leader> za

" Use enter to clear search highlighting
nmap <CR> :nohlsearch<CR>

" }}}
" FILETYPE-SPECIFIC ------------------------------------------------------- {{{

if has('autocmd')
    autocmd FileType vim setlocal foldmethod=marker
endif

" }}}
