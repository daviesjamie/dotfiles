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
