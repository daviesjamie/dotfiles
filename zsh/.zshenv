# ENVIRONMENT ------------------------------------------------------------- {{{

export EDITOR=vim
export VISUAL=$EDITOR

export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
export LC_CTYPE=en_GB.UTF-8

export FZF_DEFAULT_OPTS="--height=25% --min-height=15 --reverse"
export GHQ_ROOT="$HOME/src"

# }}}
# PATH -------------------------------------------------------------------- {{{

_add_to_path() {
    if [[ -d "$1" ]] && [[ ! $PATH =~ "$1" ]]; then
        PATH="$1:$PATH"
    fi
}

# Homebrew
_add_to_path "/opt/homebrew/bin"
_add_to_path "/usr/local/bin"

# Go
[[ -n "$GOPATH" ]] && _add_to_path "$GOPATH/bin"
[[ -n "$GOROOT" ]] && _add_to_path "$GOROOT/bin"

# Make sure things in ~ take precedence
_add_to_path "$HOME/bin"

export PATH

# }}}
