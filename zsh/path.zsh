# Force $PATH (tied to $path array) to not contain duplicates
typeset -U path

[ -d "$DOTFILES/bin" ] && path=("$DOTFILES/bin" $path)
[ -d "$HOME/bin" ] && path=("$HOME/bin" $path)

export PATH

# Load rbenv if it's installed
if command -v rbenv > /dev/null 2>&1; then
    eval "$(rbenv init -)"
fi
