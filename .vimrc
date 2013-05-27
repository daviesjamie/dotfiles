""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=500         " keep 500 lines of command line history

set number              " show line numbers
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands at the bottom
set laststatus=2        " always display the status line

set incsearch           " search incrementally as you type
set hlsearch            " highlight search matches

set backupdir=~/.tmp    " save tmp files to ~/.tmp
set directory=~/.tmp    " save swp files to ~/.tmp

set autoread            " re-read an open file that has changed outside vim

set autoindent          " automatically indent new lines
set expandtab           " use spaces instead of <tab>s
set smarttab            " make adding/removing tabs (spaces) smarter

syntax on               " turn on syntax highlighting


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

" Enable file-specific indenting and plugins
filetype plugin indent on


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
color hybrid
