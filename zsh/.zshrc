# Path to my zsh config directory
export ZSH="$HOME/.zsh"

# Load all of the config files in ~/.dotfiles/zsh that end in .zsh
for c in $ZSH/*.zsh; do source $c; done;

# Load all of the custom functions in ~/.dotfiles/zsh/functions
for i in $ZSH/functions/*; do source $i; done;

# Load ~/.zshrc.local, if it exists
[[ -s "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# End with true, so that prompt isn't discoloured by .zshrc.local not existing
true
