# Save command-line history to ~/.zsh_history
HISTFILE=$HOME/.zsh_history

# Keep 10,000 lines of history in a session
HISTSIZE=10000

# Keep 10,000 lines of history in HISTFILE
SAVEHIST=10000

# Append to the history file, rather than replace it
setopt APPEND_HISTORY

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

# Add lines to the history file as soon as they are entered
setopt INC_APPEND_HISTORY

# Share command-line history between open sessions
setopt SHARE_HISTORY
