if [ -d ~/.dotfiles ]
then
    echo "dotfiles repo is already in ~/.dotfiles"
else
    echo "cloning dotfiles to ~/.dotfiles..."
    /usr/bin/env git clone git://github.com/daviesjamie/dotfiles.git ~/.dotfiles
fi

for DOTFILE in gitconfig vimrc
do
    # If file is already installed, skip
    if [[ -L ~/.$DOTFILE && "$(readlink $HOME/.$DOTFILE)" -ef "$HOME/.dotfiles/$DOTFILE" ]]
    then
        echo "$DOTFILE is already symlinked from ~/.$DOTFILE"
        continue
    fi

    # If a file (not a symlink) already exists in place, back it up
    if [[ -f ~/.$DOTFILE && ! -L ~/.$DOTFILE ]]
    then
        echo "Found existing ~/.$DOTFILE - backing up to ~/.$DOTFILE.orig"
        cp ~/.$DOTFILE ~/.$DOTFILE.orig
        rm ~/.$DOTFILE
    fi

    # Link file into place
    echo "Symlinking $DOTFILE to ~/.$DOTFILE"
    ln -s ~/.dotfiles/$DOTFILE ~/.$DOTFILE
done

echo "Done!"
