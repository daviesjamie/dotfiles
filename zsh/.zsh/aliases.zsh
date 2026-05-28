# Detect which colour flag to use for ls
# Unix = `--color`, BSD/OSX = `-G`
if ls --color > /dev/null 2>&1; then
    colorflag='--color'
else
    colorflag='-G'
fi

# Directory listings
alias ls="ls -p ${colorflag}"
alias la='ls -A'
alias ll='ls -hl'
alias lla='ls -Ahl'

# Grep with colour
if echo | grep --color=auto '' > /dev/null 2>&1; then
    alias grep='grep --color=auto'
fi

if has hub; then
    eval "$(hub alias -s)"
fi

if has nvim; then
    alias vim=nvim
fi

if has pomodoro; then
    alias pomo=pomodoro
fi
