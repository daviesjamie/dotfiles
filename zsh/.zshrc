# Load everything in ~/.zsh, in order
for f in "$HOME/.zsh/*"; do
    [[ -f $f ]] && source $f
done

# Load ~/.zshrc.local, if it exists
[[ -s "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
