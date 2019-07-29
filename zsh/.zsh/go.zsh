# Set up go paths, if go is installed
if command -v go > /dev/null 2>&1; then
    [ -d "$HOME/go" ] && export GOPATH="$HOME/go"
    [ -d "/usr/local/opt/go/libexec" ] && export GOROOT="/usr/local/opt/go/libexec"
fi
