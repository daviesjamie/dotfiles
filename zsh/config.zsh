# Set editor to vim
export VISUAL=vim
export EDITOR=$VISUAL

# Use less as pager
export PAGER="less"
export LESS="--quit-if-one-screen --no-init --RAW-CONTROL-CHARS --chop-long-lines"

# List jobs in long format by default
setopt LONG_LIST_JOBS

# Use emacs-style keybindings (Ctrl+R for backwards search, Ctrl+U for line clear, etc)
bindkey -e
