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
Plug 'godlygeek/tabular'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'nathangrigg/vim-beancount', { 'for': 'beancount' }

if executable('ag') || executable('ack')
    Plug 'mileszs/ack.vim'
    cnoreabbrev Ag Ack
endif

" Load local plugins from ~/.vimrc.local.plugins if it exists
if filereadable(expand("~/.vimrc.local.plugins"))
    source ~/.vimrc.local.plugins
endif

call plug#end()

" Load built-in matchit.vim plugin
source $VIMRUNTIME/macros/matchit.vim

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
set shortmess+=F        " don't show message in commandline when opening files
set shortmess+=I        " don't show intro screen when opening vim
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

" Display the 78th column to hint for line length
if exists('+colorcolumn')
    set colorcolumn=80
endif

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

" Filetype-specific settings
autocmd FileType beancount  setlocal ts=2 sts=2 sw=2
autocmd FileType css        setlocal ts=2 sts=2 sw=2
autocmd FileType html       setlocal ts=2 sts=2 sw=2
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType make       setlocal ts=8 sts=8 sw=8 noexpandtab
autocmd FileType markdown   setlocal linebreak nonumber spell wrap
autocmd FileType ruby       setlocal ts=2 sts=2 sw=2
autocmd FileType scss       setlocal ts=2 sts=2 sw=2
autocmd FileType vim        setlocal foldmethod=marker
autocmd FileType yaml       setlocal ts=2 sts=2 sw=2

" Override filetype for certain files
autocmd BufNewFile,BufRead *.tt set filetype=html
autocmd BufNewFile,BufRead *.ldg,*.ledger set filetype=ledger

" }}}
" TEMPORARY FILES ---------------------------------------------------------- {{{

set history=1000                " keep 1000 lines of command line history

set backupdir=~/.vim/tmp/backup " save backup files to ~/.vim/tmp/backup
set directory=~/.vim/tmp/swap   " save swap files to ~/.vim/tmp/swap

" Create temporary folders if they don't already exist
if !isdirectory( expand( &backupdir ) )
    call mkdir( expand( &backupdir ), "p" )
endif
if !isdirectory( expand( &directory ) )
    call mkdir( expand( &directory ), "p" )
endif

" Enable saving undo history to a file, if supported
if has('persistent_undo')
    set undofile                " save undo history to a file
    set undoreload=10000        " save 10000 lines of undo history
    set undodir=~/.vim/tmp/undo " save undo files to ~/.vim/tmp/undo

    if !isdirectory( expand( &undodir ) )
        call mkdir( expand( &undodir ), "p" )
    endif
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

" Make Y behave like D, C, etc instead of dd or cc
nnoremap Y y$

" Toggle folds with double-space
nmap <leader><leader> za

" Re-select selection after indenting in visual mode
vmap > >gv
vmap < <gv

" Make readline-style Ctrl+U work in insert mode
inoremap <C-U> <C-G>u<C-U>

" Make . repeat last change in visual mode
vnoremap . :norm.<cr>

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

" Show trailing whitespace (but not on current line in insert mode)
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
augroup extrawhitespace
    au!
    au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    au InsertLeave * match ExtraWhitespace /\s\+$/
augroup END

" Jump to last position when reopening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif

" Always make sure cursor starts on first line in git commits
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

" }}}
" COLOUR SCHEME ----------------------------------------------------------- {{{

" Allow base16 themes to use 256 colourspace
let base16colorspace=256

if !empty($BASE16_THEME)
    let theme = "base16-" . $BASE16_THEME
    exec "colorscheme " . theme
else
    colorscheme base16-tomorrow-night
endif

" }}}
" STATUS LINE ------------------------------------------------------------- {{{

" Always show the statusline
set laststatus=2

function! StatuslineGit()
    if exists('*fugitive#head')
        let head = fugitive#head(8)
        return strlen(head) ? '[' . head . ']' : ''
    endif
    return ''
endfunction

set statusline=
set statusline+=%{StatuslineGit()}  " git branch (if in git repo)
set statusline+=\ %f                " filename
set statusline+=\ %h                " help buffer flag
set statusline+=%w                  " preview window flag
set statusline+=%m                  " modified flag
set statusline+=%r                  " readonly flag
set statusline+=%=
set statusline+=%y                  " type of file in buffer
set statusline+=\ [%l,%c]           " [line number, column number]

" }}}
" PLUGIN OPTIONS ---------------------------------------------------------- {{{

" Use silver search for ctrlp.vim and ack.vim, if it's installed
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
    let g:ctrlp_user_command = 'ag %s -l -g ""'
endif

" ctrlp.vim
let g:ctrlp_max_height = 30

" vim-beancount
let g:beancount_separator_col=55

" }}}

" Enable local machine-specific settings with ~/.vimrc.local
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
