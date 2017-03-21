# Load custom completions
fpath=($ZSH/completions $fpath)

# Set up completion system
autoload -U compinit
compinit
zmodload -i zsh/complist

unsetopt MENU_COMPLETE   # don't autoselect the first completion entry
setopt ALWAYS_TO_END     # always move cursor to end of word after completion
setopt AUTO_MENU         # show completion menu on succesive tab press
setopt COMPLETE_IN_WORD  # allow completing in the middle of words

# Enable menu selection
zstyle ':completion:*:*:*:*:*' menu select

# Turn off completion list colours
zstyle ':completion:*' list-colors ''

# Try completing, in order:
# - case-insensitive matches
# - partial-word matches
# - substring matches
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Auto-complete processes
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# Disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR
