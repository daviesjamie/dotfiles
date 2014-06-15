# Jamie's Dotfiles

This is a collection of the [dotfiles](http://dotfiles.github.io/) that I use to
set up a system just the way I like it.

Whilst used primarily on OS X, these dotfiles should also work on a Linux-based
system. Maybe.

This repo now uses [Dotbot](https://github.com/anishathalye/dotbot) to handle
the installation and management of the dotfiles symlinks. To view the
purpose-built tool that I wrote to manage the files before Dotbot, view the
[my_tool](https://github.com/daviesjamie/dotfiles/tree/my_tool) branch.

## Installation

To install these dotfiles on your system, simply:

```
$ git clone https://github.com/daviesjamie/dotfiles.git ~/.dotfiles
$ ~/.dotfiles/install
```

This will create a symlink in the correct place in your home directory to each
dotfile. The install script is idempotent - running it multiple times won't
cause any issues, it will just update the git submodules.

### Manual Installation

If you don't want to use Dotbot to install the dotfiles, then you can manually
create a symlink to each file yourself with the following command:

``` $ ln -s ~/.dotfiles/.gitignore ~/.gitignore ```

Rinse and repeat for each file in this repository that you wish to use.

## Credits

Several other projects have provided me with ideas (and sometimes just a little
code!) for this project:
 - Mathias Bynens' [excellent collection of OS
   X defaults](https://github.com/mathiasbynens/dotfiles/blob/master/.osx).
 - Steve Losh's [detailed and lengthy
   dotfiles](https://bitbucket.org/sjl/dotfiles).
