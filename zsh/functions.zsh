# `g` with no arguments -> `git status`
#     with arguments    -> `git <args>`
function g() {
    if [[ $# -gt 0 ]]; then
        git "$@"
    else
        git status
    fi
}

# Create a new directory and cd into it
function take() {
    mkdir -p "$@" && cd "$@";
}

