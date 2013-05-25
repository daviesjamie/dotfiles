import argparse, glob, os, shutil, subprocess, sys

IGNORED_FILES = [__file__, '.git', 'README.md']
BACKUP_SUFFIX = '~'

################################################################################
# Helper Functions
################################################################################

def ask_yn(question):
    question += ' (y/n):  '
    answer = None

    while answer not in ['yes', 'y', 'no', 'n']:
        answer = raw_input(question).lower()

    return answer.startswith('y')


def pretty_basename(path):
    name = os.path.basename(path)
    if os.path.isdir(path):
        name += '/'
    return name

def run(command):
    return subprocess.call(command, shell=True)


################################################################################
# Dotfiles Functions
################################################################################

def get_dotfiles(dotfiles_dir):
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


def create_symlinks(dotfiles, force=False):
    print 'Linking files into home directory...'
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
                        backup = ask_yn(name + ' already exists, back it up?' )
                    else:
                        backup = False
                    
                    if backup:
                        # Back up dest, using BACKUP_SUFFIX
                        backup_dest = dest + BACKUP_SUFFIX
                        while os.path.exists(backup_dest):
                            backup_dest += BACKUP_SUFFIX

                        os.rename(dest, backup_dest)
                        print 'BACKED UP - ' + name + ' to ' + backup_dest
                    else:
                        # Replace dest
                        os.remove(dest)

                print 'REMOVED - ' + name
            else:
                # Sucessfully linked
                print 'LINKED - ' + name
                installed = True

    print 'Linking complete! ' + str(len(dotfiles)) + ' files were linked.'


################################################################################
# Installation Functions
################################################################################

def install_oh_my_zsh():
    run("git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh")
    run("chsh -s /bin/zsh")


################################################################################
# Main Function
################################################################################

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-f', '--force', help='Automatically overwrite any files, instead of asking you whether to back up or not (Use with CAUTION!)', action='store_true')

    args = parser.parse_args()

    # Install oh-my-zsh (if not already installed)?
    installed_oh_my_zsh = os.path.exists(os.path.join(os.path.expanduser('~'), '.oh-my-zsh'))
    if not installed_oh_my_zsh and ask_yn('Install oh-my-zsh?'):
        install_oh_my_zsh()
        installed_oh_my_zsh = True

    # Get dotfiles directory
    dot_dir = os.path.dirname(os.path.realpath(__file__))

    # Get a list of all the dotfiles
    dot_names = get_dotfiles(dot_dir)

    # Create the symlinks to those files
    create_symlinks(dot_names, force=args.force)

    print '\nInstallation Complete.'

    # Print tips
    if not installed_oh_my_zsh:
        print "You didn't install oh-my-zsh, so you probably want to remove the oh-my-zsh lines from .zshrc!"
    

if __name__ == '__main__':
    main()