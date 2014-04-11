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

set hidden              " Allow buffers to exist in the background

set number              " show absolute line number on current line
set cursorline          " highlight the line the cursor is on
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands at the bottom
set scrolloff=5         " keep 5 lines visible around cursor (if possible)
set matchtime=3         " highlight matching parens for 3 seconds

set textwidth=80        " set maximum line width to 80 characters
"set colorcolumn=+1      " draw a right margin at the end of textwidth
set linebreak           " use soft-wrapping on long lines
set formatoptions=cqanb1j " see :h formatoptions, there's too much to explain

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

" Change cursor to | when in insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

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
" COMPLETION --------------------------------------------------------------- {{{

" When tab-completing with more than one match, list all matches and complete
" till longest common string
set wildmode=list:longest

" Use a menu for command-line completion
set wildmenu

" Stuff to ignore when tab-completing
set wildignore+=*DS_Store*
set wildignore+=*.pyc
set wildignore+=*.png,*.jpg,*.gif

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
noremap <C-w>h <C-w>10<
noremap <C-w>j <C-w>10-
noremap <C-w>k <C-w>10+
noremap <C-w>l <C-w>10>

" Move to next/previous buffers easier
noremap <leader>x :bnext<cr>
noremap <leader>z :bprevious<cr>

" Copying to/from system clipboard
noremap <leader>y "*y
noremap <leader>p :set paste<cr>o<esc>"*]p:set nopaste<cr>

" Select contents of current line (excluding indentation)
nnoremap vv ^vg_

" Clear search highlighting
nnoremap <cr> :nohlsearch<cr>

" Toggle NERDTree
noremap <F2> :NERDTreeToggle<cr>

" }}}
" :COMMAND SHORTCUTS ------------------------------------------------------- {{{

" Close the current buffer and switch back to the old one
cnoremap bq bp <bar> bd #

" Quickly edit main dotfiles
cnoremap ev vsplit $MYVIMRC
cnoremap eg vsplit ~/.gitconfig
cnoremap ef vsplit ~/.config/fish/config.fish
cnoremap essh vsplit ~/.ssh/config
"
" Write to protected file (request sudo)
cnoremap w!! w !sudo tee %

" }}}
" VUNDLE ------------------------------------------------------------------- {{{

" Install with:
" $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" :BundleInstall

" Use ZSH as shell (vundle doesn't like fish!)
set shell=/bin/zsh

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let vundle manage vundle (required)
Bundle 'gmarik/vundle'

" Hybrid colour scheme
Bundle 'w0ng/vim-hybrid'

" Solarized colour schemes
Bundle 'altercation/vim-colors-solarized'

" Airline status bar
Bundle 'bling/vim-airline'

" Alternative hybrid theme for airline
Bundle 'daviesjamie/airline-hybrid-alt'

" Show buffers in the status bar
Bundle 'bling/vim-bufferline'

" Fugitive.vim, an awesome git wrapper
Bundle 'tpope/vim-fugitive'

" NerdTREE file tree browser
Bundle 'scrooloose/nerdtree'

" Enable file-specific indenting and plugins
filetype plugin indent on

" }}}
" COLOUR SCHEME ------------------------------------------------------------ {{{

" Enable 256 colours
set t_Co=256
"
" Enable hybrid theme
colorscheme hybrid

" }}}
" AIRLINE / BUFFERLINE ----------------------------------------------------- {{{

set noshowmode      " stop vim displaying the mode, as airline now shows it
set laststatus=2    " always display the status line

" Use base16 theme
let g:airline_theme='hybridalt'

" Turn on fancy separators
let g:airline_left_sep=''
let g:airline_right_sep=''

" Don't collapse left section of airline when inactive
let g:airline_inactive_collapse=0

" Stop bufferline showing on command line
let g:bufferline_echo=0

" Put [ ] around the active buffer (but only when there's more than one)
let g:bufferline_active_buffer_left='['
let g:bufferline_active_buffer_right=']'

" Don't display buffer numbers
let g:bufferline_show_bufnr=0

" Custom airline layout
" mode | buffers/filename [RO]                  branch | [warnings]
let g:airline_section_a = '%{airline#util#wrap(airline#parts#mode(),0)}%{airline#util#append(airline#parts#paste(),0)}%{airline#util#append(airline#parts#iminsert(),0)}'
let g:airline_section_b = ''
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = '%{airline#util#wrap(airline#extensions#branch#get_head(),0)}'

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

" }}}
" GUI / MACVIM ------------------------------------------------------------- {{{

if has("gui_running")
    set guioptions-=T   " Hide toolbar
    set guioptions-=rR  " Hide right scrollbar
    set guioptions-=b   " Hide bottom scrollbar
    set guioptions-=lL  " Hide left scrollbar

    " Set default window size
    set columns=100 lines=30

    " Configure font
    set guifont=Anonymous\ Pro
    set noantialias
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
