# oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="daviesjamie"
plugins=(brew git mvn nyan sublime svn zsh)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Load $PATH
[ -f ~/.path ] && source ~/.path

# Load Aliases
[ -f ~/.aliases ] && source ~/.aliases
