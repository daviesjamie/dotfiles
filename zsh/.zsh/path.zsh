# Force $PATH (tied to $path array) to not contain duplicates
typeset -U path

[ -d "$HOME/bin" ] && path=("$HOME/bin" $path)

# rbenv
[ -d "$HOME/.rbenv/bin" ] && path=("$HOME/.rbenv/bin" $path)
[ -d "$HOME/.rbenv/plugins/ruby-build/bin" ] && path=("$HOME/.rbenv/plugins/ruby-build/bin" $path)

export PATH
