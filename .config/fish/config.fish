# ALIASES ------------------------------------------------------------------ {{{

# Directories
function ..; cd ..; end
function ...; cd ../..; end
function ....; cd ../../..; end
function .....; cd ../../../..; end
function take; mkdir -p $argv; cd $argv; end

# Dotfiles shortcuts
function reloadf; source ~/.config/fish/config.fish; end
function ef; eval $EDITOR ~/.config/fish/config.fish; reloadf; end
function ev; eval $EDITOR ~/.vimrc; end
function eg; eval $EDITOR ~/.gitconfig; end
function essh; eval $EDITOR ~/.ssh/config; end

# Git shortcuts
function git; hub $argv; end
function g; git $argv; end
function gi; curl http://www.gitignore.io/api/$argv; end
function gist; command gist -c $argv; end

# Directory listings
function l; ls -p $argv; end
function la; ls -Ap $argv; end
function ll; ls -hlp $argv; end
function lla; ls -Alp $argv; end

# Clipboard
function pbc; pbcopy; end
function pbp; pbpaste; end

# Homebrew shortcuts
function brup; brew update; brew upgrade; brew cleanup; end

# Latex compilation
function mtex; latexmk -pdf -pvc $argv; end
function mtexs; latexmk -pdf -pvc $argv >- ^- &; end

# Execute last command with root privileges
function sudo!!; eval sudo $history[1]; end

# Python shortcuts
function py; python $argv; end
function pipup; pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U; end

# Todor shortcuts
function todor; /Users/jamie/Code/todor/todor.py $argv; end
function t; todor $argv; end

# Sick of GUI-based vim, stick to the classic!
function v; vim $argv; end

# }}}
# COMPLETIONS -------------------------------------------------------------- {{{

function make_completion --argument alias command
    complete -c $alias -xa "(
        set -l cmd (commandline -pc | sed -e 's/^ *\S\+ *//' );
        complete -C\"$command \$cmd\";
    )"
end

make_completion g "git"

# }}}
# ENVIRONMENT VARIABLES ---------------------------------------------------- {{{

function _prepend_to_path -d "Prepend the given dir to PATH if it exists and is not already in it"
    if test -d $argv[1]
        if not contains $argv[1] $PATH
            set -gx PATH "$argv[1]" $PATH
        end
    end
end

set -gx PATH "/usr/texbin"
_prepend_to_path "/sbin"
_prepend_to_path "/usr/sbin"
_prepend_to_path "/bin"
_prepend_to_path "/usr/bin"
_prepend_to_path "/usr/local/bin"
_prepend_to_path "/usr/local/opt/ruby/bin"
_prepend_to_path "$HOME/bin"

set BROWSER open
set -gx fish_greeting ''
set -gx EDITOR vim

set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home

# }}}
# PROMPT ------------------------------------------------------------------- {{{

function pwd_prompt -d 'Print current working directory, using ~ instead of $HOME'
    echo $PWD | sed -e "s|^$HOME|~|"
end

function git_prompt
    if git rev-parse --show-toplevel >/dev/null 2>&1
        set_color normal
        printf ' on '
        set_color magenta
        printf '%s' (git rev-parse --abbrev-ref HEAD ^/dev/null)
        set_color red
        git_prompt_status
        set_color normal
    end
end

function virtualenv_prompt
    if [ -n "$VIRTUAL_ENV" ]
        printf '%s ' (basename "$VIRTUAL_ENV")
    end
end

function fish_prompt
    echo

    set_color magenta
    printf '%s' (whoami)
    set_color normal
    printf ' at '

    set_color yellow
    printf '%s' (hostname | cut -d . -f 1)
    set_color normal
    printf ' in '

    set_color $fish_color_cwd
    printf '%s' (pwd_prompt)
    set_color normal

    git_prompt

    echo

    set_color blue
    virtualenv_prompt
    set_color normal

    printf '→ '

    set_color normal
end

# }}}
# VIRTUALFISH -------------------------------------------------------------- {{{

source ~/.config/fish/virtualfish/virtual.fish
source ~/.config/fish/virtualfish/auto_activation.fish

# }}}
