# CHECKS ------------------------------------------------------------------- {{{

if [[ $(uname) = 'Linux' ]]; then
    IS_LINUX=1
fi

if [[ $(uname) = 'Darwin' ]]; then
    IS_MAC=1
fi

if [[ -x `which brew` ]]; then
    HAS_BREW=1
fi

if [[ -x `which apt-get` ]]; then
    HAS_APT=1
fi

# }}}
# ALIASES ------------------------------------------------------------------ {{{

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
function take { mkdir -p $1 && cd $1 }

# Dotfiles shortcuits
alias eg='$EDITOR ~/.gitconfig'
alias essh='$EDITOR ~/.ssh/config'
alias ev='$EDITOR ~/.vimrc'
alias ez='$EDITOR ~/.zshrc'

# Git shortcuts
alias git='hub'
function g() {
    if [[ -z $1 ]]; then
        git status
    else
        git $*
    fi
}

# Directory listings
alias l='ls -p'
alias la='ls -Ap'
alias ll='ls -hlp'
alias lla='ls -Alp'

# Clipboard
alias pbc='pbcopy'
alias pbp='pbpaste'

# Homebrew
alias brup='brew update && brew upgrade && brew cleanup'

# Latex compilation
alias mtex='latexmk -pdf -pvc'

# Python
alias py='python'
alias ipy='ipython'
alias pipup="pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U"

# Todor
alias todor='/Users/jamie/Code/todor/todor.py'
alias t='todor'

# Vim
alias v='vim'

# }}}
# OPTIONS ------------------------------------------------------------------ {{{

setopt no_beep              # Don't beep on error
setopt noclobber            # Try and avoid accidental clobbering of files with >

setopt auto_cd              # `cd dir` == `dir`
setopt cdablevarS           # Can pass variables to `cd`
setopt pushd_ignore_dups    # Don't stack multiple copies of the same dir

setopt extended_glob        # Use '#', '~', and '^' in globs

setopt append_history       # Multiple sessions append to same history file
setopt extended_history     # Save timestamp and duration of command
setopt inc_append_history   # Add commands as they are entered
setopt hist_expire_dups_first # When trimming history, lose oldest dups first
setopt hist_ignore_dups     # Don't add duplicate commands to history
setopt hist_ignore_space    # Don't add commands starting with whitespace
setopt hist_find_no_dups    # When searching history don't display duplicates
setopt hist_reduce_blanks   # Trim whitespace when adding to history
setopt hist_verify          # Don't execute, just expand history
setopt share_history        # Imports new and appends typed commands to history
HISTSIZE=1000               # Keep 1000 commands in history

setopt correct              # Spelling correction for commands
setopt correctall           # Spelling correction for arguments

setopt prompt_subst         # Enable substitutions and expansions inside prompt
setopt transient_rprompt    # Only show rprompt on the current prompt

setopt multios              # Implicitly allow multiple redirections

# }}}
# EXPORTS ------------------------------------------------------------------ {{{

PATH="/usr/texbin"
PATH="/sbin:$PATH"
PATH="/usr/sbin:$PATH"
PATH="/bin:$PATH"
PATH="/usr/bin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/usr/local/opt/ruby/bin:$PATH"
PATH="$HOME/bin:$PATH"
export PATH

export HISTSIZE=10000
export SAVEHIST=9000
export HISTFILE=~/.zsh_history

export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home'

export BROWSER='open'
export EDITOR='vim'
export PAGER='less'

# }}}
# COLORS ------------------------------------------------------------------- {{{

autoload colors; colors

# Export some useful color presets
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
    eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
    eval PR_BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

# Clear LSCOLORS
unset LSCOLORS

# Set LSCOLORS
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

# }}}
# PROMPT ------------------------------------------------------------------- {{{

function _prompt_char {
    echo '→'
}

function _prompt_git_branch {
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    echo " on ${PR_MAGENTA}${ref#refs/heads/}%{$reset_color%}"
}

function _prompt_pwd {
    echo $( PWD | sed -e "s|^$HOME|~|" )
}

function _prompt_virtualenv {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`')'
}

PROMPT='
${PR_MAGENTA}%n%{$reset_color%} at ${PR_BLUE}%m%{$reset_color%} in ${PR_CYAN}$(_prompt_pwd)%{$reset_color%}$(_prompt_git_branch)
$(_prompt_char) '

RPROMPT='${PR_BLUE}$(_prompt_virtualenv)%{$reset_color%}'

SPROMPT='Correct ${PR_RED}%R%{$reset_color%} to ${PR_GREEN}%r%{$reset_color%} [(y)es (n)o (a)bort (e)dit]? '

# }}}
# COMPLETIONS -------------------------------------------------------------- {{{

# Load and run compinit
autoload -U compinit && compinit
zmodload -i zsh/complist

# Don't autoselect the first completion entry
unsetopt menu_complete
unsetopt flowcontrol

# Show completion menu on successive tab presses
setopt auto_menu

setopt nonomatch            # Disable error message when no match is found
setopt complete_in_word     # Allow completion from inside a word
setopt always_to_end        # Complete in middle of word moves cursor to end
setopt auto_name_dirs       # Use names to describe directories

if [[ $ZSH_VERSION == 3.<->* ]]; then
    which zmodload >&/dev/null && zmodload zsh/compctl
    compctl -c sudo
    compctl -c which
    compctl -g '*(-/)' + -g '.*(-/)' -v cd pushd rmdir
    compctl -k hosts -x 'p[2,-1]' -l '' -- rsh ssh
    return 0
fi

# man zshcontrib
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:*' enable git svn #cvs

# Enable completion caching, use rehash to clear
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# Fallback to built in ls colors
zstyle ':completion:*' list-colors ''

# Make the list prompt friendly
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'

# Make the selection prompt friendly when there are a lot of choices
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Add simple colors to kill
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# List of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

zstyle ':completion:*' menu select=1 _complete _ignored _approximate

# Insert all expansions for expand completer
# zstyle ':completion:*:expand:*' tag-order all-expansions

# Match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# Ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:scp:*' tag-order files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

# }}}
# ANTIGEN PLUGINS ---------------------------------------------------------- {{{

# Load antigen script
source ~/.antigen/antigen.zsh

# Syntax highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

    # Set highlighters to use
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)

# Up/down history completion
antigen bundle zsh-users/zsh-history-substring-search

    # Bind up/down arrow keys
    zmodload zsh/terminfo
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down

# oh-my-zsh `brew` completions
antigen bundle robbyrussell/oh-my-zsh.git plugins/brew

# Apply changes
antigen apply

# }}}
