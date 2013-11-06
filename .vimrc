" GENERAL OPTIONS ---------------------------------------------------------- {{{
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

set encoding=utf-8      " use utf-8 character set by default
syntax on               " turn on syntax highlighting

set number              " show line numbers
set cursorline          " highlight the line the cursor is on
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands at the bottom
set scrolloff=5         " keep 5 lines visible around cursor (if possible)
set colorcolumn=80      " draw a right margin at the 80th character

set incsearch           " search incrementally as you type
set hlsearch            " highlight search matches
set ignorecase          " use case-insensitive search
set smartcase           " automatically decide to search with case or not
set gdefault            " global substitution by default

set autoread            " re-read an open file that has changed outside vim

set tabstop=4           " set hard tabstop size to 4
set softtabstop=4       " set soft tabstop size to 4
set shiftwidth=4        " set size of an 'indent' to 4
set autoindent          " automatically indent new lines
set expandtab           " use spaces instead of <tab>s
set smarttab            " make adding/removing tabs (spaces) smarter

set noesckeys           " remove the delay when hitting esc in insert mode
set ttimeout
set ttimeoutlen=1

" Make vim return to the same line when reopening a file
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

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

" Stop using the cursor keys once and for all! (Unbind them)
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Make j and k work on screen lines, not file lines
nnoremap j gj
nnoremap k gk

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

" My bundles
Bundle 'w0ng/vim-hybrid'
Bundle 'bling/vim-airline'

" Enable file-specific indenting and plugins
filetype plugin indent on

" }}}
" COLOUR SCHEME ------------------------------------------------------------ {{{

set t_Co=256    " Enable 256 colours
color hybrid    " Use hybrid as colour scheme (installed through Vundle)

" }}}
" AIRLINE ------------------------------------------------------------------ {{{

set noshowmode          " stop vim displaying the mode, as powerline now shows it
set laststatus=2        " always display the status line
let g:airline_powerline_fonts=1 " Use powerline font symbols
let g:airline_theme='zenburn'   " Use zenburn theme

" }}}
" FILETYPE SPECIFIC SETTINGS ----------------------------------------------- {{{
" Fish {{{
augroup ft_fish
    au!
    au BufNewFile,BufRead *.fish setlocal filetype=fish
    au FileType fish setlocal foldmethod=marker foldmarker={{{,}}}
augroup END
" }}}
" Vim {{{
augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker foldmarker={{{,}}}
augroup END
" }}}
" }}}
