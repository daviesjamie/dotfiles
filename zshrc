# Path to my dotfiles
export DOTFILES=$HOME/.dotfiles

# Path to my zsh config directory
export ZSH=$DOTFILES/zsh

# Load all of the config files in ~/.dotfiles/zsh that end in .zsh
for i in $ZSH/*.zsh; do source $i; done;
