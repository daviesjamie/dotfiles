#!/usr/bin/env python

import argparse, glob, os, shutil, subprocess, sys

# List of files inside the dotfiles folder to ignore (and not link), that
# aren't specified through .gitignore
IGNORED_FILES = [os.path.basename(__file__), '.git', 'README.md']

# Suffix to use when creating a backup of a file
BACKUP_SUFFIX = '~'


################################################################################
# Helper Functions
################################################################################

def ask_yn(question):
    """Presents the user with a question, and takes a yes (True) or no (False)
    answer in response.
    """

    question += ' (y/n):  '
    answer = None

    while answer not in ['yes', 'y', 'no', 'n']:
        answer = raw_input(question).lower()

    return answer.startswith('y')


def pretty_basename(path):
    """Returns the basename of the given path, with a trailing '/' if the
    basename of the path is a directory.
    """
    name = os.path.basename(path)
    if os.path.isdir(path):
        name += '/'
    return name


def run(command):
    """Runs a given command externally in the shell."""
    return subprocess.call(command, shell=True)


################################################################################
# Dotfiles Functions
################################################################################

def get_dotfiles(dotfiles_dir):
    """Returns a list of the files in the dotfiles directory that are actually
    valid dotfiles.

    A list of all the files in the dotfiles directory is narrowed down, with all
    files specified by the .gitignore file removed. All files that are
    arbitrarily specified in the IGNORED_FILES list are also removed. The
    resulting list is then returned.
    """

    # Get all files in the current directory
    dot_all = os.listdir(dotfiles_dir)

    # Ignore all files that match a dotfiles/.gitignore pattern
    gitignore = os.path.join(dotfiles_dir, '.gitignore')
    dot_actual = dot_all[:]
    if os.path.exists(gitignore):
        with open(gitignore) as gi:
            for line in gi:
                if line != '\n' and not line.startswith('#'):
                    pattern = line.rstrip('\n')
                    patterns = [pattern]

                    # use git smart wildcards
                    if pattern.startswith('*'):
                        patterns.append('.' + pattern)  # *a == *a and .*a
                    if pattern.startswith('*.'):
                        patterns.append(pattern[1:])  # *.b == *.b and .b

                    for pattern in patterns:
                        for path in glob.iglob(os.path.join(dotfiles_dir, pattern)):
                            name = os.path.basename(path)
                            if name in dot_actual:
                                dot_actual.remove(name)

    # Ignore any extra files that we have specified in the IGNORED_FILES list
    for igf in IGNORED_FILES:
        if(igf in dot_actual):
            dot_actual.remove(igf)

    # Return a list of the actual dotfiles (with their paths)
    return [os.path.join(dotfiles_dir, name) for name in dot_actual]


def create_symlinks(dotfiles, force=False, quiet=False):
    """Creates links to the specified dotfiles in the user's home directory.

    Goes through a list of files/directories and creates a symlink in the user's
    home directory to each one. If a file/directory with the same name already
    exists in the user's home directory, it will ask the user if they wish to
    back up that file (by appending BACKUP_SUFFIX to the filename) before
    creating the link.

    Args:
        dotfiles: A list of the files/directories to create links for.
        force: Whether to force overwriting of clashing files. If set to True,
            the script will not ask if the user wants to backup any files that
            already exist; they will just be overwritten.
        quiet: Whether or not to output anything. If set to True, the script
            will automatically back up all file clashes without asking the
            user. If force is also True, there will still be no output, but the
            script will automatically overwrite everything.
    """

    if not quiet: print 'Linking files into home directory...'
    home_dir = os.path.expanduser('~')

    for path in sorted(dotfiles):
        dest = os.path.join(home_dir, os.path.basename(path))
        name = pretty_basename(path)
        installed = False

        while not installed:
            try:
                os.symlink(path, dest)
            except OSError:
                # If dest already exists, offer to back it up
                if os.path.isdir(dest) and not islink(dest):
                    shutil.rmtree(dest)
                else:
                    if not force:
                        if not quiet:
                            backup = ask_yn(name + ' already exists, back it up?' )
                        else:
                            backup = True
                    else:
                        backup = False
                    
                    if backup:
                        # Back up dest, using BACKUP_SUFFIX
                        backup_dest = dest + BACKUP_SUFFIX
                        while os.path.exists(backup_dest):
                            backup_dest += BACKUP_SUFFIX

                        os.rename(dest, backup_dest)
                        if not quiet: print 'BACKED UP - ' + name + ' to ' + backup_dest
                    else:
                        # Replace dest
                        os.remove(dest)

                if not quiet: print 'REMOVED - ' + name
            else:
                # Sucessfully linked
                if not quiet: print 'LINKED - ' + name
                installed = True

    if not quiet: print 'Linking complete! ' + str(len(dotfiles)) + ' files were linked.'


################################################################################
# Installation Functions
################################################################################

def install_oh_my_zsh(quiet=False):
    """Installs oh-my-zsh from GitHub.

    If the user doesn't already have oh-my-zsh installed, it asks them if they
    would like to install it. If they answer yes, then install it (respecting
    the quiet option).

    Returns a boolean representing whether oh-my-zsh is installed.
    """

    installed_oh_my_zsh = os.path.exists(os.path.join(os.path.expanduser('~'), '.oh-my-zsh'))
    
    if not installed_oh_my_zsh:
        if not quiet:
            if ask_yn('Install oh-my-zsh?'):
                run('git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh')
                run('chsh -s /bin/zsh')
                installed_oh_my_zsh = True
        else:
            run('git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh &> /dev/null')
            run('chsh -s /bin/zsh &> /dev/null')
            installed_oh_my_zsh = True

    return installed_oh_my_zsh


################################################################################
# Main Function
################################################################################

def main():
    """The function called when the script is executed. Controls the main flow
    of the program.
    """

    parser = argparse.ArgumentParser()
    parser.add_argument('-f', '--force', help='Automatically overwrite any files, instead of asking you whether to back up or not (Use with CAUTION!)', action='store_true')
    parser.add_argument('-q', '--quiet', help='The script will not output anything. It will automatically backup all files and install all dependencies.', action='store_true')
    args = parser.parse_args()

    # Install oh-my-zsh (if not already installed)?
    installed_oh_my_zsh = install_oh_my_zsh(quiet=args.quiet)

    # Get dotfiles directory
    dot_dir = os.path.dirname(os.path.realpath(__file__))

    # Get a list of all the dotfiles
    dot_names = get_dotfiles(dot_dir)

    # Create the symlinks to those files
    create_symlinks(dot_names, force=args.force, quiet=args.quiet)

    # Print done message(s).
    if not args.quiet:
        print '\nInstallation Complete.'
        if not installed_oh_my_zsh:
            print "You didn't install oh-my-zsh, so you probably want to remove the oh-my-zsh lines from .zshrc!"
    

if __name__ == '__main__':
    main()