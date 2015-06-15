# ALIASES ------------------------------------------------------------------ {{{

# Directory listings
function l --wraps 'ls'; ls -p $argv; end
function la --wraps 'ls'; ls -Ap $argv; end
function ll --wraps 'ls'; ls -hlp $argv; end
function lla --wraps 'ls'; ls -Alp $argv; end

# Make a new directory and move into it
function take; mkdir -p $argv; cd $argv; end

# Dotfiles shortcuts
function reloadf; source ~/.config/fish/config.fish; end
function ef; eval $EDITOR ~/.config/fish/config.fish; reloadf; end
function ev; eval $EDITOR ~/.vimrc; end
function eg; eval $EDITOR ~/.gitconfig; end
function essh; eval $EDITOR ~/.ssh/config; end

# Git shortcuts
function git; hub $argv; end
function g --wraps 'git'
    if test (count $argv) -gt 0
        git $argv
    else
        git status
    end
end

# Clipboard
function pbc; pbcopy $argv; end
function pbp; pbpaste $argv; end

# Homebrew shortcuts
function brup; brew update; brew upgrade --all; brew cleanup; end
function cask; brew cask $argv; end

# LaTeX compilation
function mtex; latexmk -pdf -pvc $argv; end

# Python shortcuts
function py --wraps 'python'; python $argv; end
function ipy --wraps 'python'; ipython $argv; end

# Make `sudo !!` work again!
function sudo
    if test "$argv" = "!!"
        eval command sudo $history[2]
    else
        command sudo $argv
    end
end

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

set -gx BROWSER open
set -gx EDITOR vim

# }}}
# PROMPT ------------------------------------------------------------------- {{{

# Remove greeting message
set -g fish_greeting

# Configure __fish_git_prompt
set -g __fish_git_prompt_showdirtystate true
set -g __fish_git_prompt_showstashstate true
set -g __fish_git_prompt_showuntrackedfiles true
set -g __fish_git_prompt_showcolorhints true
set -g __fish_git_prompt_color_branch magenta
set -g __fish_git_prompt_color_flags red
set -g __fish_git_prompt_char_untrackedfiles '?'

# Configure prompt
set -g __fish_prompt_color_venv yellow
set -g __fish_prompt_color_path cyan
set -g __fish_prompt_color_char normal
set -g __fish_prompt_color_char_error red
set -g __fish_prompt_char_user '→'
set -g __fish_prompt_char_root '⇉'

# }}}
# VIRTUAL FISH ------------------------------------------------------------- {{{

. ~/.config/fish/virtualfish/virtual.fish
. ~/.config/fish/virtualfish/auto_activation.fish

# }}}
