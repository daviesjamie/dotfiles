# OPTIONS ----------------------------------------------------------------- {{{

# Write lines to $HISTFILE once they've finished executing
setopt INC_APPEND_HISTORY_TIME

# Save start/end timestamps for each command in history
setopt EXTENDED_HISTORY

# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list
setopt HIST_IGNORE_ALL_DUPS

# Don't add any lines starting with whitespace to history
setopt HIST_IGNORE_SPACE

# Remove unnecessary whitespace from commands when saving to history
setopt HIST_REDUCE_BLANKS

# When using history substitution (such as sudo !!), don't execute line
# directly - instead load it into prompt for editing
setopt HIST_VERIFY

# Use emacs-style keybindings (Ctrl+R for backwards search, Ctrl+U for line clear, etc)
bindkey -e

# Force mapping of home/delete/end keys to the right thing
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char

# }}}
# HOOKS ------------------------------------------------------------------- {{{

function has() {
  command -v "$1" > /dev/null 2>&1
}

if has ,tmux-sesh; then
  bindkey -s ^g ",tmux-sesh\n"
fi

# `brew shellenv` is called from .zprofile

if has direnv; then
    eval "$(direnv hook zsh)"
fi

if has flux; then
    eval "$(flux completion zsh)"
fi

if has fnm; then
    eval "$(fnm env --shell zsh --use-on-cd)"
    eval "$(fnm completions --shell zsh)"
fi

if has fzf; then
    eval "$(fzf --zsh)"
fi

if has mise; then
    eval "$(mise activate zsh)"
fi

if has oh-my-posh; then
  eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh.omp.json)"
fi

if has starship; then
  eval "$(starship init zsh)"
fi

if has talosctl; then
    eval "$(talosctl completion zsh)"
fi

if has tinty; then
    tinty init
    eval "$(tinty generate-completion zsh)"
fi

# }}}
# OTHER FILES ------------------------------------------------------------- {{{

files=(
  "$HOME/.zsh/aliases.zsh"
  "$HOME/.zsh/functions.zsh"
  "$HOME/.zsh/completion.zsh"
  "$HOME/.zshrc.local"
)

for f in $files; do
  [[ -f $f ]] && source $f
done

# }}}
