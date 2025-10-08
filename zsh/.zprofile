# ENVIRONMENT ------------------------------------------------------------- {{{

export EDITOR=nvim
export VISUAL=$EDITOR

export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
export LC_CTYPE=en_GB.UTF-8

export GHQ_ROOT="$HOME/src"
export PNPM_HOME="/Users/jagd/Library/pnpm"

# }}}
# HOMEBREW ---------------------------------------------------------------- {{{

if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f "/usr/local/bin/brew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# }}}
# PATH -------------------------------------------------------------------- {{{

path=(
  "$HOME/bin"
  "$HOME/.local/share/bob/nvim-bin"  # bob
  "$HOME/go/bin"                     # Go
  "$HOMEBREW_PREFIX/bin"             # Homebrew
  $path
)

# Remove duplicates
typeset -U path

# Remove non-existent directories
path=($^path(N-/))

export PATH

# }}}
# FPATH -------------------------------------------------------------------- {{{

fpath=(
    "$HOME/zsh/completions"
    "$HOME/.docker/completions"
    "$HOMEBREW_PREFIX/share/zsh/site-functions"
    $fpath
)

# Remove duplicates
typeset -U fpath

# Remove non-existent directories
fpath=($^fpath(N-/))

export FPATH

# }}}
# RUST --------------------------------------------------------------------- {{{

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# }}}
