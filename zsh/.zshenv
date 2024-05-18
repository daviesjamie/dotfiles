# ENVIRONMENT ------------------------------------------------------------- {{{

export EDITOR=nvim
export VISUAL=$EDITOR

export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
export LC_CTYPE=en_GB.UTF-8

export GHQ_ROOT="$HOME/src"

# Homebrew
# Generated with `brew shellenv`
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

# }}}
# PATH -------------------------------------------------------------------- {{{

_add_to_path() {
    if [[ -d "$1" ]] && [[ ! $PATH =~ "$1" ]]; then
        PATH="$1:$PATH"
    fi
}

# Homebrew
_add_to_path "/opt/homebrew/bin"

# Make sure things in ~ take precedence
_add_to_path "$HOME/bin"

export PATH

# }}}
# FPATH -------------------------------------------------------------------- {{{

typeset -U fpath

ZSH_PROFILES=(
  "/usr/share"
  "/opt/homebrew/share/zsh"
)

for profile in ${ZSH_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done

# }}}
