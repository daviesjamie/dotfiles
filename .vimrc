" BASIC OPTIONS ------------------------------------------------------------ {{{

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

set modelines=0         " explicity turn off vim modelines (for security)
set encoding=utf-8      " use utf-8 character set by default
syntax on               " turn on syntax highlighting
set synmaxcol=800       " don't highlight lines longer than 800 characters

set ttyfast             " use a fast terminal connection
set visualbell          " use a visual bell instead of annoying beep
set title               " update the terminal title with file name

set number              " show line numbers
set cursorline          " highlight the line the cursor is on
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands at the bottom
set scrolloff=5         " keep 5 lines visible around cursor (if possible)
set matchtime=3         " highlight matching parens for 3 seconds

set textwidth=80        " set maximum line width to 80 characters
"set colorcolumn=+1      " draw a right margin at the end of textwidth
set linebreak           " use soft-wrapping on long lines
set formatoptions=crqn1j " see :h formatoptions, there's too much to explain

set tabstop=4           " set hard tabstop size to 4
set softtabstop=4       " set soft tabstop size to 4
set shiftwidth=4        " set size of an 'indent' to 4
set shiftround          " when shifting, always use a multiple of shiftwidth
set autoindent          " automatically indent new lines
set expandtab           " use spaces instead of <tab>s
set smarttab            " make adding/removing tabs (spaces) smarter

set incsearch           " search incrementally as you type
set hlsearch            " highlight search matches
set ignorecase          " use case-insensitive search
set smartcase           " automatically decide to search with case or not
set gdefault            " global substitution by default

set autoread            " re-read an open file that has changed outside vim

set noesckeys           " remove the delay when hitting esc in insert mode
set notimeout           " timeout out on keycodes, but not mappings
set ttimeout
set ttimeoutlen=10      " wait 10ms for a keycode to complete

set splitbelow          " always make new splits below, not above
set splitright          " always make new splits on the right, not on the left

" Set dictonary files
set dictionary=/usr/share/dict/words
set spellfile=~/.vim/custom-dictionary.utf-8.add

" }}}
" ADVANCED OPTIONS --------------------------------------------------------- {{{

" Highlight VCS conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Make vim return to the same line when reopening a file
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Only show cursorline in normal mode and in the current window
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" Resize splits when the window is resized
au VimResized * :wincmd =

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
" FOLDING ------------------------------------------------------------------ {{{

set foldlevelstart=0

" Use space to toggle folds
nnoremap <Space> za

" }}}
" KEY BINDINGS ------------------------------------------------------------- {{{

" Set leader keys
let mapleader=","
let maplocalleader="\\"

" Stop using the cursor keys once and for all! (Unbind them)
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" Make j and k work on screen lines, not file lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Move between windows a bit easier
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Resize splits more easily
noremap <C-w>h <C-w>10>
noremap <C-w>j <C-w>10-
noremap <C-w>k <C-w>10+
noremap <C-w>l <C-w>10<

" Toggle line numbers
nnoremap <leader>n :setlocal number!<cr>

" System clipboard
noremap <leader>y "*y
noremap <leader>p "*p

" Select contents of current line (excluding indentation)
nnoremap vv ^vg_

" Quickly edit main dotfiles
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>eg :vsplit ~/.gitconfig<cr>
nnoremap <leader>ef :vsplit ~/.config/fish/config.fish<cr>

" Turn off search highlighting
nnoremap <leader><space> :nohlsearch<cr>

" Write to protected file (request sudo)
noremap <leader>W :w !sudo tee %<cr>

" Toggle NERDTree
noremap <F2> :NERDTreeToggle<cr>

" }}}
" VUNDLE ------------------------------------------------------------------- {{{

" Install with:
" $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" :BundleInstall

" Use ZSH as shell (vundle doesn't like fish!)
set shell=/bin/zsh

filetype on
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let vundle manage vundle (required)
Bundle 'gmarik/vundle'

" Luna colour scheme
Bundle 'Pychimp/vim-luna'

" Solarized colour schemes
Bundle 'altercation/vim-colors-solarized'

" Airline status bar
Bundle 'bling/vim-airline'

" Fugitive.vim, an awesome git wrapper
Bundle 'tpope/vim-fugitive'

" NerdTREE file tree browser
Bundle 'scrooloose/nerdtree'

" Enable file-specific indenting and plugins
filetype plugin indent on

" }}}
" COLOUR SCHEME ------------------------------------------------------------ {{{
"
" Enable 256 colours
set t_Co=256
"
" Use luna as colour scheme (installed through Vundle)
colorscheme luna-term

" }}}
" AIRLINE ------------------------------------------------------------------ {{{

set noshowmode          " stop vim displaying the mode, as powerline now shows it
set laststatus=2        " always display the status line

let g:airline_powerline_fonts=0 " Use powerline font symbols
" Use luna theme
let g:airline_theme='luna'

" Turn on fancy separators
let g:airline_left_sep=''
let g:airline_right_sep=''

" }}}
" NERDTREE ----------------------------------------------------------------- {{{

" Highlight the line the cursor is on
let NERDTreeHighlightCursorline=1

" Hide unecessary help message and 'Bookmarks' title
let NERDTreeMinimalUI=1

" Use arrow/triangle symbols instead of | and +
let NERDTreeDirArrows=1

" Use more colours
let NERDChristmasTree=1

" Change Vim's working directory whenever NERDTree's directory is changed
let NERDTreeChDirMode=2

" Leave NERDTree open after selecting a file
let NERDTreeQuitOnOpen=0

" Ignore (don't display) some files
let NERDTreeIgnore = ['\.pyc$']

" Automatically open NERDTree if no arguments are given to vim
autocmd vimenter * if !argc() | NERDTree | endif

" }}}
" GUI / MACVIM ------------------------------------------------------------- {{{

if has("gui_running")
    set guioptions-=T   " Hide toolbar
    set guioptions-=r   " Hide right scrollbar
    set guioptions-=b   " Hide bottom scrollbar
    set guioptions-=l   " Hide left scrollbar

    " Set default window size
    set columns=200 lines=50

    " Configure font
    set guifont=Inconsolata:h14
    set antialias

    " Hide solarized menu
    let g:solarized_menu=0

    " Enable solarized theme
    syntax enable
    set background=light
    colorscheme solarized

    " Toggle between light/dark theme with <leader>b or F5
    so ~/.vim/bundle/vim-colors-solarized/autoload/togglebg.vim
    nnoremap <leader>b :ToggleBG<cr>
endif

" }}}
" FILETYPE SPECIFIC SETTINGS ----------------------------------------------- {{{

" Fish {{{

augroup ft_fish
    au!
    au BufNewFile,BufRead *.fish setlocal filetype=fish
    au FileType fish setlocal foldmethod=marker foldmarker={{{,}}}
augroup END

" }}}
" Python {{{

augroup ft_python
    au!
    au FileType python setlocal foldmethod=indent foldlevel=99
augroup END

" }}}
" TeX/LaTeX {{{

augroup ft_tex
    au!
    au FileType tex setlocal spell spelllang=en_gb
augroup END

" }}}
" Vim {{{

augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker foldmarker={{{,}}}
augroup END

" }}}

" }}}
