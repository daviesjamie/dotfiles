""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

set encoding=utf-8      " use utf-8 character set by default

set history=1000        " keep 1000 lines of command line history
set undolevels=1000     " keep 1000 steps in the undo history

set number              " show line numbers
set relativenumber      " use relative line numbers
set cursorline          " highlight the line the cursor is on
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands at the bottom
set laststatus=2        " always display the status line

set incsearch           " search incrementally as you type
set hlsearch            " highlight search matches
set ignorecase          " use case-insensitive search
set smartcase           " automatically decide to search with case or not
set gdefault            " global substitution by default

set backupdir=~/.tmp    " save tmp files to ~/.tmp
set directory=~/.tmp    " save swp files to ~/.tmp

set autoread            " re-read an open file that has changed outside vim

set tabstop=4           " set hard tabstop size to 4
set softtabstop=4       " set soft tabstop size to 4
set shiftwidth=4        " set size of an 'indent' to 4
set autoindent          " automatically indent new lines
set expandtab           " use spaces instead of <tab>s
set smarttab            " make adding/removing tabs (spaces) smarter

set noesckeys           " Remove the delay when hitting esc in insert mode
set ttimeout
set ttimeoutlen=1

syntax on               " turn on syntax highlighting


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stop using the cursor keys once and for all! (Unbind them)
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install with:
" $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" :BundleInstall

filetype on
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let vundle manage vundle (required)
Bundle 'gmarik/vundle'

" My bundles
Bundle 'vim-scripts/wombat256.vim'
Bundle 'w0ng/vim-hybrid'
Bundle 'Lokaltog/vim-powerline'

" Enable file-specific indenting and plugins
filetype plugin indent on


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle Package settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color scheme (installed as a vundle)
set t_Co=256
color hybrid

" Powerline settings
let g:Powerline_symbols = 'fancy'
set noshowmode          " stop vim displaying the mode, as powerline now shows it