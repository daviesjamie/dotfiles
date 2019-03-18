# Set up go paths, if go is installed
if command -v go > /deb/null 2>&1; then
    export GOPATH="$HOME/.go"
    export GOROOT="$(brew --prefix golang)/libexec"
fi
