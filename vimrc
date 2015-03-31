" BASIC OPTIONS ------------------------------------------------------------ {{{

" Use Vim settings, rather than Vi settings (much better!).
set nocompatible

" Recognise function keys that start with <Esc> in insert mode
" Allows use/mapping of cursor keys, and removes delay when hitting escape
set noesckeys

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

set modelines=0         " explicity turn off vim modelines (for security)
set encoding=utf-8      " use utf-8 character set by default
syntax on               " turn on syntax highlighting
set synmaxcol=800       " don't highlight lines longer than 800 characters

set ttyfast             " use a fast terminal connection
set visualbell          " use a visual bell instead of annoying beep
set title               " update the terminal title with file name

set hidden              " allow unsaved buffers to exist in the background

set number              " use line numbers
set cursorline          " highlight the line the cursor is on
set scrolloff=5         " keep 5 lines visible around cursor (if possible)
set sidescrolloff=5     " keep 5 characters visible around cursor (if possible)

set display+=lastline   " display as much as possible of a long last line
set linebreak           " use soft-wrapping on long lines

set formatoptions=q     " allow formatting of comments with gq
set formatoptions+=n    " recognise numbered lists when formatting
set formatoptions+=l    " don't automatically format/wrap already too-long lines
set formatoptions+=1    " don't break lines after a one-letter word

" Remove comment markup when joining lines
if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j
endif

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

set autoread            " re-read an open file that has changed outside vim
set autowrite           " automatically save before commands like :next and :make

set notimeout           " timeout out on keycodes, but not mappings
set ttimeout
set ttimeoutlen=10      " wait 10ms for a keycode to complete

set splitbelow          " always make new splits below, not above
set splitright          " always make new splits on the right, not on the left
set spelllang=en_gb     " set spelling to use British English

set showcmd             " display incomplete commands at the bottom
set cmdheight=2         " use 2 lines for command-line
set laststatus=2        " Always display statusbar, regardless of number of windows

" Set dictonary files
set dictionary=/usr/share/dict/words
set spellfile=~/.vim/custom-dictionary.utf-8.add

" If using Fish shell, use bash inside vim
if &shell =~# 'fish$'
    set shell=/bin/bash
endif

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

" Strip trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

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

" Stop using the cursor keys once and for all! (Unbind them)
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

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

" Clear search highlighting
nnoremap <leader><space> :nohlsearch<cr>

" }}}
" :COMMAND SHORTCUTS ------------------------------------------------------- {{{

" Quickly edit main dotfiles
cabbrev ev e $MYVIMRC
cabbrev eg e ~/.gitconfig
cabbrev ef e ~/.config/fish/config.fish
cabbrev essh e ~/.ssh/config
cabbrev vv vsplit $MYVIMRC
cabbrev vg vsplit ~/.gitconfig
cabbrev vf vsplit ~/.config/fish/config.fish
cabbrev vssh vsplit ~/.ssh/config

" Write to protected file (request sudo)
cabbrev w!! w !sudo tee %

" Prefer help in vertical splits
cabbrev h vert help

" }}}
" PLUGINS ------------------------------------------------------------------ {{{

" Install with:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" :PlugInstall

" Initialise vim-plug
filetype off
call plug#begin('~/.vim/plugged')

" Colour schemes
Plug 'jonathanfilip/vim-lucius'

" Tim Pope goodness
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Editing plugins
Plug 'godlygeek/tabular'
Plug 'sirver/ultisnips'
Plug 'wellle/targets.vim'

call plug#end()

" Enable file-specific indenting and plugins
filetype plugin indent on

" }}}
" COLOUR SCHEME ------------------------------------------------------------ {{{

" Enable 256 colours
set t_Co=256

" Enable lucius theme
colorscheme lucius
set background=dark

" }}}
" STATUSLINE --------------------------------------------------------------- {{{

function! Color(active, num, content)
    if a:active
        return '%' . a:num . '*' . a:content . '%*'
    else
        return a:content
    endif
endfunction

function! Status(winnr)
    let stat = ''
    let active = winnr() == a:winnr
    let buffer = winbufnr(a:winnr)

    let modified = getbufvar(buffer, '&modified')
    let readonly = getbufvar(buffer, '&ro')
    let filetype = getbufvar(buffer, '&ft')

    " Column number
    let stat .= '%1*' . (col(".") / 100 >= 1 ? '%v ' : ' %2v') . ' %*'

    " Filename
    let stat .= Color(active, 3, active ? ' [' : '  ')
    let stat .= ' %<'
    let stat .= '%f'
    let stat .= Color(active, 3, active ? ' ]' : '  ')


    " Modified flag
    let stat .= Color(active, 2, modified ? ' +' : '')

    " Read only flag
    let stat .= Color(active, 2, readonly ? ' !!' : '')

    " Paste mode flag
    if active && &paste
        let stat .= ' %2*' . 'P' . '%*'
    endif

    " Switch to right side
    let stat .= '%='

    " Filetype
    let stat .= Color(active, 3, ' ← ') . filetype . ' '

    return stat
endfunction

" Cycle through windows and re-set the statusline
" Used to provide an 'inactive' colourscheme for inactive windows
function! SetStatus()
    for nr in range(1, winnr('$'))
        call setwinvar(nr, '&statusline', '%!Status('.nr.')')
    endfor
endfunction

" Automatically call SetStatus() when necessary
augroup status
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter,BufUnload * call SetStatus()
augroup END

" Background colour
hi StatusLine   ctermfg=243 guifg=#767676 ctermbg=237 guibg=#3a3a3a
hi StatusLineNC ctermfg=238 guifg=#444444 ctermbg=236 guibg=#303030

" Column number colour
hi User1 ctermfg=243 guifg=#767676  ctermbg=236 guibg=#303030

" Modified/Read-only/Paste colour
hi User2 ctermfg=197 guifg=#ff005f  ctermbg=237 guibg=#3a3a3a

" [ ] ← colour
hi User3 ctermfg=136 guifg=#af8700  ctermbg=237 guibg=#3a3a3a

" }}}
" ULTISNIPS ---------------------------------------------------------------- {{{

" Use tab to expand snippets
let g:UltiSnipsExpandTrigger='<tab>'

" Use tab and shift+tab for jumping between tabstops/placeholders
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" Use vertical split for :UltiSnipsEdit
let g:UltiSnipsEditSplit='vertical'

" }}}
" GUI / MACVIM ------------------------------------------------------------- {{{

if has("gui_running")
    set guioptions-=T   " Hide toolbar
    set guioptions-=rR  " Hide right scrollbar
    set guioptions-=b   " Hide bottom scrollbar
    set guioptions-=lL  " Hide left scrollbar
    set guioptions+=c   " Use vim-style prompts instead of popup dialog boxes

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
augroup END

" }}}
" TeX/LaTeX {{{

augroup ft_tex
    au!
    au FileType tex setlocal spell
augroup END

" }}}
" Folding Files {{{
augroup fold_ft
    au!
    au FileType conf,fish,vim setlocal foldmethod=marker foldmarker={{{,}}}
augroup END
" }}}

" }}}
