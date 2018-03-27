# Dotfiles

These are my dotfiles, to set up a system just the way I like it.

There are configurations for both Mac and Linux programs, and they are all (hopefully) independent - so you can pick and choose which configurations you want to install.

## Installation

These dotfiles are organised in a format that makes them very easy to manage using [GNU Stow](http://www.gnu.org/software/stow/):

```
$ git clone --recurse-submodules https://github.com/daviesjamie/dotfiles ~/.dotfiles
$ cd ~/.dotfiles

# Install vim configuration
$ stow vim

# Uninstall vim configuration
$ stow -D vim

# Reinstall vim configuration (useful for removing obsolete symlinks)
$ stow -R vim
```

If you don't want to install Stow, manually symlinking them into place should also suffice:

```
$ ln -s ~/.dotfiles/vim/.vimrc ~/.vimrc
```
