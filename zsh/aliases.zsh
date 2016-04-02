# Detect which colour flag to use for ls
# Unix = `--color`
# BSD/OSX = `-G`
if ls --color > /dev/null 2>&1; then
    colorflag='--color'
else
    colorflag='-G'
fi

# Directory listings
alias ls='ls -p ${colorflag}'
alias l='ls'
alias la='ls -A'
alias ll='ls -hl'
alias lla='ls -Ahl'

# File system tree
alias .='pwd'
alias ..='cd ..'
alias ...='cd ../..'

# Grep with colour
if echo | grep --color=auto '' > /dev/null 2>&1; then
    alias grep='grep --color=auto'
fi

# Clipboard
if command -v pbcopy > /dev/null 2>&1; then
    alias pbc='pbcopy'
    alias pbp='pbpaste'
elif command -v xclip > /dev/null 2>&1; then
    alias pbc='xclip -selection clipboard'
    alias pbp='xclip -selection clipboard -o'
fi

# Alias git to hub, if it's installed
if command -v hub > /dev/null 2>&1; then
    eval "$(hub alias -s)"
fi
