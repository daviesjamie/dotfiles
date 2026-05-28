# Quickly cd into repositories cloned with `ghq`
if has ghq; then
    function ,gcd() {
        local repo
        local repo_path

        if [[ $# -gt 0 ]]; then
            repo=$(ghq list | fzf -1 -q "$*")
        else
            repo=$(ghq list | fzf)
        fi

        [ $? -eq 0 ] && repo_path=$(ghq list -p -e $repo) && cd $repo_path
    }
fi

# Create a new directory and cd into it
function ,mkcd() {
    mkdir -p "$1" && cd "$1";
}

# Create a new temp directory and cd into it
function ,tmp() {
    cd "$(mktemp -d)"
    if [[ $# -eq 1 ]]; then
      mkdir -p "$1"
      cd "$1"
    fi
}
