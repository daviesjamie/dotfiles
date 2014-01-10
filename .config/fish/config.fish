# ALIASES ------------------------------------------------------------------ {{{
# Directories
function ..; cd ..; end
function ...; cd ../..; end
function ....; cd ../../..; end
function .....; cd ../../../..; end
function take; mkdir -p $argv; cd $argv; end

# Dotfiles shortcuts
function ef; vim ~/.config/fish/config.fish; end
function ev; vim ~/.vimrc; end
function eg; vim ~/.gitconfig; end

# Git shortcuts
function git; hub $argv; end
function g; git $argv; end

# Directory listings
function l; ls $argv; end
function la; ls -A $argv; end
function ll; ls -l $argv; end
function lla; ls -lA $argv; end

# Clipboard
function pbc; pbcopy; end
function pbp; pbpaste; end

# Latex compilation
function mtex; latexmk -pdf -pvc $argv; end
function mtexs; latexmk -pdf -pvc $argv >- ^- &; end
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

    set_color 515151
    virtualenv_prompt
    set_color normal

    printf '→ '

    set_color normal
end
# }}}
# VIRTUALFISH -------------------------------------------------------------- {{{
. ~/.config/fish/virtualfish/virtual.fish
. ~/.config/fish/virtualfish/auto_activation.fish
# }}}
