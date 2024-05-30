# jagd's dotfiles

Yup, these are my dotfiles, they set things up just the way I want 'em.

They've been around the block and have taken many different forms over the years, including using multiple different dotfile management tools (even Nix and home-manager at one point), but I just keep coming back to this approach of simple files and symlinks managed by [GNU Stow][stow].

## Installation

These dotfiles are organised in a format that makes them very easy to manage using [GNU Stow][stow]:

```sh
$ git clone https://github.com/daviesjamie/dotfiles ~/.dotfiles
$ cd ~/.dotfiles

# Install vim configuration
$ stow vim

# Uninstall vim configuration
$ stow -D vim

# Reinstall vim configuration (useful for removing obsolete symlinks)
$ stow -R vim
```

If you don't want to install Stow, manually symlinking them into place should also suffice:

```sh
$ ln -s ~/.dotfiles/vim/.vimrc ~/.vimrc
```

[stow]: http://www.gnu.org/software/stow/
