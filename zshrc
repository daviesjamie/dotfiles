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

# Set editor to vim
export VISUAL=vim
export EDITOR=VISUAL

# Load base16 colourscheme
[[ -z "$THEME" ]] && export THEME="base16-tomorrow"
[[ -z "$THEME_BG" ]] && export THEME_BG="dark"

BASE16_SCRIPT="$BASE16_SHELL/$THEME.$THEME_BG.sh"
[[ -s $BASE16_SCRIPT ]] && source $BASE16_SCRIPT
