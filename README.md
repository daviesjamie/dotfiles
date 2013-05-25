# Jamie's Dotfiles

This ~~is~~ *will be* a collection of the [dotfiles](http://dotfiles.github.io/) that I use to set up a system just the way I like it.

I am currently only using this repository on OS X, but I plan to one day get around to using it on Linux as well - and so there shouldn't be any issues running it on a Linux system.

## Installation

To install these dotfiles on your system, simply:

```
$ git clone https://github.com/daviesjamie/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ ./install.py
```

The installer script will create a symlink to each dotfile in your home directory, asking if you want to back up any files already in your home directory that conflict with the ones in this repository.

The script will also ask if you want to install the dependencies for these dotfiles, such as [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh).

### Options

The following options can be passed to the installer script:

***`-f, --force`***<br />
&nbsp;&nbsp;&nbsp;&nbsp;Automatically overwrite any files, instead of asking you whether to back up or not (Use with **caution**!).

***`-q, --quiet`***<br />
&nbsp;&nbsp;&nbsp;&nbsp;The script will not output anything. It will automatically backup all files and install all dependencies.

***`-h, --help`***<br />
&nbsp;&nbsp;&nbsp;&nbsp;Show a list of the options and a brief explanation of what they do.

## Credits

Several other projects have provided me with ideas (and sometimes just a little code!) for this project:
 - Maciej Konieczny's [dotfiles installer script](https://github.com/narfdotpl/dotfiles).
 - Jon Bernard's [Python dotfiles management system](https://github.com/jbernard/dotfiles).
 - Mathias Bynens' [excellent collection of OS X defaults](https://github.com/mathiasbynens/dotfiles/blob/master/.osx).