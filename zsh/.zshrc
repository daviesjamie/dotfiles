# Load everything in ~/.zsh, in order
for f in $HOME/.zsh/*; do
    [[ -f $f ]] && source $f
done

# Load ~/.zshrc.local, if it exists
# Use not-or construct in order to still return true if the file doesn't exist
# (as we don't want the prompt to be discoloured)
[[ ! -s "$HOME/.zshrc.local" ]] || source "$HOME/.zshrc.local"
