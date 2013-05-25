from glob import iglob
from os import listdir, remove, symlink
from os.path import basename, dirname, exists, expanduser, isdir, join, realpath
from shutil import rmtree

IGNORED_FILES = [__file__, '.git', 'README.md']

def get_dotfiles(dotfiles_dir):
    # Get all files in the current directory
    dot_all = listdir(dotfiles_dir)

    # Ignore all files that match a dotfiles/.gitignore pattern
    gitignore = join(dotfiles_dir, '.gitignore')
    dot_actual = dot_all[:]
    if exists(gitignore):
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
                        for path in iglob(join(dotfiles_dir, pattern)):
                            name = basename(path)
                            if name in dot_actual:
                                dot_actual.remove(name)

    # Ignore any extra files that we have specified in the IGNORED_FILES list
    for igf in IGNORED_FILES:
        if(igf in dot_actual):
            dot_actual.remove(igf)

    # Return a list of the actual dotfiles (with their paths)
    return [join(dotfiles_dir, name) for name in dot_actual]


def create_symlinks(dotfiles):
    home_dir = expanduser('~')

    for path in sorted(dotfiles):
        dest = join(home_dir, basename(path))
        name = _pretty_basename(path)
        installed = False

        while not installed:
            try:
                symlink(path, dest)
            except OSError:
                # If dest already exists
                if isdir(dest) and not islink(dest):
                    rmtree(dest)
                else:
                    remove(dest)

                print "REMOVED - " + name
            else:
                # Sucessfully linked
                print "LINKED - " + name
                installed = True

    print "Linking Complete: " + str(len(dotfiles)) + " files were linked."


def _pretty_basename(path):
    name = basename(path)
    if isdir(path):
        name += '/'
    return name


def main():
    # Get dotfiles directory
    dot_dir = dirname(realpath(__file__))

    # Get a list of all the dotfiles
    dot_names = get_dotfiles(dot_dir)

    # Create the symlinks to those files
    create_symlinks(dot_names)
    

if __name__ == '__main__':
    main()