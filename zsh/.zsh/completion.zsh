zmodload zsh/complist

setopt MENU_COMPLETE     # autoselect the first completion entry
setopt AUTO_MENU         # show completion menu on successive tab press
setopt COMPLETE_IN_WORD  # allow completing the middle of words

# : completion : <function> : <completer> : <command> : <argument> : <tag>

# Define completer precedence
# _extensions: complete globs with possible file extensions
# _complete: main completion engine
# _approximate: completion engine with typo correction
zstyle ':completion:*' completer _extensions _complete _approximate

# Enable menu selections
zstyle ':completion:*' menu select

zstyle ':completion:*:*:*:*:messages' format ' %F{purple}-- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

# Try completing, in order:
# - case-insensitive matches
# - partial-word matches
# - substring matches
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
