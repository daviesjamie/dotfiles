# Path to my dotfiles
export DOTFILES="$HOME/.dotfiles"

# Path to my zsh config directory
export ZSH="$DOTFILES/zsh"

# Path to base16 theme scripts
export BASE16_SHELL="$DOTFILES/.config/base16-shell"

# Load all of the config files in ~/.dotfiles/zsh that end in .zsh
for c in $ZSH/*.zsh; do source $c; done;

# Load all of the custom functions in ~/.dotfiles/zsh/functions
for i in $ZSH/functions/*; do source $i; done;

# Load base16 colourscheme
[[ -z "$THEME" ]] && export THEME="base16-tomorrow-night"

BASE16_SCRIPT="$BASE16_SHELL/scripts/$THEME.sh"
[[ -s $BASE16_SCRIPT ]] && source $BASE16_SCRIPT

# Load ~/.zshrc.local, if it exists
[[ -s "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# End with true, so that prompt isn't discoloured by failing checks above
true
