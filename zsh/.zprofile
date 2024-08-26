# ENVIRONMENT ------------------------------------------------------------- {{{

export EDITOR=nvim
export VISUAL=$EDITOR

export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
export LC_CTYPE=en_GB.UTF-8

export GHQ_ROOT="$HOME/src"

# Homebrew
eval "$(brew shellenv)"

# }}}
# PATH -------------------------------------------------------------------- {{{

path=(
  "$HOME/bin"
  "$HOME/.local/bin"      # pipx
  "$HOME/.rd/bin"         # Rancher desktop
  "$HOMEBREW_PREFIX/bin"  # Homebrew
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
