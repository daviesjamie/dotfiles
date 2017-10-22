# Force $PATH (tied to $path array) to not contain duplicates
typeset -U path

[ -d "$HOME/bin" ] && path=("$HOME/bin" $path)

[ -d "$HOME/.rbenv/bin" ] && path=("$HOME/.rbenv/bin" $path)
[ -d "$HOME/.rbenv/plugins/ruby-build/bin" ] && path=("$HOME/.rbenv/plugins/ruby-build/bin" $path)

export PATH

# Load rbenv if it's installed
if command -v rbenv > /dev/null 2>&1; then
    eval "$(rbenv init -)"
fi
