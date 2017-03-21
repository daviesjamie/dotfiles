# Use emacs-style keybindings (Ctrl+R for backwards search, Ctrl+U for line clear, etc)
bindkey -e

# Force mapping of home/delete/end keys to the right thing
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char

# Use ctrl-o in completion menu to accept current selection and open another
# menu
bindkey -M menuselect '^o' accept-and-infer-next-history
