# Dotfiles shortcuts
function ef; vim ~/.config/fish/config.fish; end
function ev; vim ~/.vimrc; end
function eg; vim ~/.gitconfig; end

# Genearl shortcuts
function git; hub $argv; end
function g; git $argv; end

function l; ls $argv; end
function la; ls -a $argv; end
function ll; ls -l $argv; end
function lla; ls -la $argv; end

function pbc; pbcopy; end
function pbp; pbpaste; end

function take; mkdir -p $argv; cd $argv; end

# Completions
function make_completion --argument alias command
    complete -c $alias -xa "(
        set -l cmd (commandline -pc | sed -e 's/^ *\S\+ *//' );
        complete -C\"$command \$cmd\";
    )"
end

make_completion g "git"

# Environment Variables
function prepend_to_path -d "Prepend the given dir to PATH if it exists and is not already in it"
    if test -d $argv[1]
        if not contains $argv[1] $PATH
            set -gx PATH "$argv[1]" $PATH
        end
    end
end

set -gx PATH "/usr/texbin"
prepend_to_path "/sbin"
prepend_to_path "/usr/sbin"
prepend_to_path "/bin"
prepend_to_path "/usr/bin"
prepend_to_path "/usr/local/bin"
prepend_to_path "/usr/local/share/python"
prepend_to_path "/usr/local/opt/ruby/bin"
prepend_to_path "$HOME/bin"

set BROWSER open
set -gx fish_greeting ''
set -gx EDITOR vim

# Prompt
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
        printf '(%s) ' (basename "$VIRTUAL_ENV")
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

    virtualenv_prompt

    printf '→ '

    set_color normal
end

true
