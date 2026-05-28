# ENVIRONMENT ------------------------------------------------------------- {{{

export EDITOR="nvim"
export VISUAL="nvim"

export LANG="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"
export LC_CTYPE="en_GB.UTF-8"

export DOTFILES="$HOME/.dotfiles"
export GHQ_ROOT="$HOME/src"
export XDG_CONFIG_HOME="$HOME/.config"

# }}}
# ZSH --------------------------------------------------------------------- {{{

# Save command-line history to ~/.zsh_history
HISTFILE=$HOME/.zsh_history

# Keep 10,000 lines of history in a session
HISTSIZE=10000

# Keep 10,000 lines of history in HISTFILE
SAVEHIST=10000

# }}}
# HOMEBREW ---------------------------------------------------------------- {{{

# This should probably be loaded in .zshrc,
# but I want to use $HOMEBREW_PREFIX for the PATH variables below

if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"  # aarch
elif [ -f "/usr/local/bin/brew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"     # x86
fi

# }}}
# PATH -------------------------------------------------------------------- {{{

path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/go/bin"
  "$HOMEBREW_PREFIX/bin"
  $path
)

# Remove duplicates and non-existent dirs
typeset -U path
path=($^path(N-/))

export PATH

# }}}
# FPATH -------------------------------------------------------------------- {{{

fpath=(
    "$HOMEBREW_PREFIX/share/zsh/site-functions"
    $fpath
)

# Remove duplicates and non-existent dirs
typeset -U fpath
fpath=($^fpath(N-/))

export FPATH

# }}}
# LS_COLORS ---------------------------------------------------------------- {{{

# Attributes	   ;    Text	           ;     Background
# 00 none	            30 black                 40  black
# 01 bold               31 red                   41  red
# 04 underline          32 green                 42  green
# 05 blink              33 yellow                43  yellow
# 07 reverse            34 blue                  44  blue
# 08 concealed          35 magenta               45  magenta
#                       36 cyan                  46  cyan
#                       37 white                 47  white
#                       90 dark grey             100 dark grey
#                       91 light red             101 light red
#                       92 light green           102 light green
#                       93 light yellow          103 light yellow
#                       94 light blue            104 light blue
#                       95 light purple          105 light purple
#                       96 turquoise             106 turqoise

# di    = directory
# fi    = file
# ln    = symbolic link
# pi    = fifo file
# so    = socket file
# bd    = block (buffered) special file
# cd    = character (unbuffered) special file
# or    = symbolic link pointing to a non-existent file (orphan)
# mi    = non-existent file pointed to by a symbolic link (visible when you type ls -l)
# ex    = file which is executable (ie. has 'x' set in permissions).
# *.rpm = files with the ending .rpm

# show directories in bold light blue
LS_COLORS="di=01;94"

# show symbolic links in cyan
LS_COLORS="${LS_COLORS}:ln=00;36"

# show broken symbolic links in light red
LS_COLORS="${LS_COLORS}:or=00;91"

# show executable files in light green
LS_COLORS="${LS_COLORS}:ex=00;92"

export LS_COLORS

# }}}

[[ -f "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"
