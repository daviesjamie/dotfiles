if [ -d ~/.dotfiles ]
then
    echo "dotfiles repo is already in ~/.dotfiles"
else
    echo "cloning dotfiles to ~/.dotfiles..."
    /usr/bin/env git clone git://github.com/daviesjamie/dotfiles.git ~/.dotfiles
fi

for dotfile in $( find ~/.dotfiles -type f -maxdepth 1 \
                ! \( -iname '.*' -or -iname 'install.sh' \) \
                | xargs basename );
do
    # If file is already installed, skip it
    if [[ -L ~/.$dotfile && "$(readlink $HOME/.$dotfile)" -ef "$HOME/.dotfiles/$dotfile" ]]
    then
        echo "$dotfile is already symlinked from ~/.$dotfile"
        continue
    fi

    # If a file (not a symlink) already exists in place, back it up
    if [[ -f ~/.$dotfile && ! -L ~/.$dotfile ]]
    then
        echo "Found existing ~/.$dotfile - backing up to ~/.$dotfile.orig"
        cp ~/.$dotfile ~/.$dotfile.orig
        rm ~/.$dotfile
    fi

    # Link file into place
    echo "Symlinking $dotfile to ~/.$dotfile"
    ln -s ~/.dotfiles/$dotfile ~/.$dotfile
done

echo "Done!"
