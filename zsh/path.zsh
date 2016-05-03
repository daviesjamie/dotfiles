# Force $PATH (tied to $path array) to not contain duplicates
typeset -U path

[ -d "$DOTFILES/bin" ] && path=("$DOTFILES/bin" $path)

export PATH
