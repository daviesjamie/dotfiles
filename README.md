# Jamie's Dotfiles

This is a collection of the [dotfiles](http://dotfiles.github.io/) that I use to set up a system just the way I like it.

Whilst used primarily on OS X, these dotfiles should also work on a Linux-based system. Maybe.

## Installation

To install these dotfiles on your system, simply:

```
$ git clone https://github.com/daviesjamie/dotfiles.git ~/.dotfiles
$ ~/.dotfiles/bin/dotfiles link
```

The script will create a symlink in the correct place in your home directory to each dotfile, asking if you want to back up any files already in your home directory that conflict with the ones in this repository.

Once installed, the `dotfiles` tool will be on your `$PATH`, and accessible from anywhere on your system.

### Usage
The following commands can be used with the `dotfiles` tool:

 - `link [-f|--force] [files]`<br />
Creates symlinks for the specified dotfiles, or all files if none are specified. Prompts user to backup existing files in the home directory. Can be used with the force option to automatically overwrite any existing files.

 - `list [-u|--unlinked]`<br />
Lists all dotfiles in the repo that have been linked into the user's home directory. Can be used with the unlinked option to instead list all dotfiles that haven't been linked into the home directory.

 - `add <files>`<br />
Moves the specified configuration file(s) to the dotfiles repository. Will automatically create the appropriate folder structure inside the dotfiles repo. *Warning:* likely to die horrifically if used on a file outside of the home directory tree!

 - `edit <dotfile>`<br />
Opens up the system `$EDITOR` (or `vim`, if `$EDITOR` doesn't exist) to edit the specified dotfile.

**Note:** All dotfiles are specified by their path relative to the root of the repository, e.g., `.vimrc` or `bin/git_prompt_status`

### Manual Installation

If you don't want to use the tool to install the dotfiles, then you can
manually create a symlink to each file yourself with the following command:

```
$ ln -s ~/.dotfiles/.gitignore ~/.gitignore
```

Rinse and repeat for each file in this repository that you wish to use.

## Credits

Several other projects have provided me with ideas (and sometimes just a little
code!) for this project:
 - Mathias Bynens' [excellent collection of OS
   X defaults](https://github.com/mathiasbynens/dotfiles/blob/master/.osx).
 - Steve Losh's [detailed and lengthy
   dotfiles](https://bitbucket.org/sjl/dotfiles).
