# Force $PATH (tied to $path array) to not contain duplicates
typeset -U path

[ -d "$HOME/bin" ] && path=("$HOME/bin" $path)

# go
[ -n "$GOPATH" ] && [ -d "$GOPATH/bin" ] && path=("$GOPATH/bin" $path)
[ -n "$GOPATH" ] && [ -d "$GOROOT/bin" ] && path=("$GOROOT/bin" $path)

# rbenv
[ -d "$HOME/.rbenv/bin" ] && path=("$HOME/.rbenv/bin" $path)
[ -d "$HOME/.rbenv/plugins/ruby-build/bin" ] && path=("$HOME/.rbenv/plugins/ruby-build/bin" $path)

# yarn
[ -d "$HOME/.yarn/bin" ] && path=("$HOME/.yarn/bin" $path)

export PATH
