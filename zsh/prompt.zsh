# Allow extra expansion for prompt sequences
setopt PROMPT_SUBST

# Prompt character to use
PROMPT_SYMBOL='❯'

# Character to use to show git repo has uncommitted changes
PROMPT_GIT_DIRTY_SYMBOL='*'

# Max execution time of a process before its run time is shown when it exits
CMD_MAX_EXEC_TIME=10

# Colours to use
PROMPT_USER_COLOUR=4
PROMPT_ROOT_COLOUR=3
PROMPT_HOST_COLOUR=5
PROMPT_PATH_COLOUR=6
PROMPT_GIT_COLOUR=8
PROMPT_EXEC_TIME_COLOUR=3
PROMPT_SYMBOL_COLOUR=7
PROMPT_SYMBOL_NON_ZERO_COLOUR=1


# Turn seconds into human-readable time, and store it in supplied varible name
_prompt_human_time_to_var() {
    local human=" " total_seconds=$1 var=$2
    local days=$(( total_seconds / 60 / 60 / 24 ))
    local hours=$(( total_seconds / 60 / 60 % 24 ))
    local minutes=$(( total_seconds / 60 % 60 ))
    local seconds=$(( total_seconds % 60 ))
    (( days > 0 )) && human+="${days}d "
    (( hours > 0 )) && human+="${hours}h "
    (( minutes > 0 )) && human+="${minutes}m "
    human+="${seconds}s"
    typeset -g "${var}"="${human}"
}

# Store the exec time of the last command if set threshold was exceeded
_prompt_check_cmd_exec_time() {
    integer elapsed
    (( elapsed = EPOCHSECONDS - ${prompt_cmd_timestamp:-$EPOCHSECONDS} ))
    if [[ elapsed -gt $CMD_MAX_EXEC_TIME ]]; then
        _prompt_human_time_to_var $elapsed "prompt_cmd_exec_time"
    else
        unset prompt_cmd_exec_time
    fi
}

_prompt_git_dirty_to_var() {
    local var=$1
    unset "${var}"

    # check if we're in a git repo
    command git rev-parse --is-inside-work-tree &> /dev/null || return

    # check if it's dirty
    test -z "$(command git status --porcelain --ignore-submodules -unormal)"
    if [[ $? -eq 1 ]]; then
        typeset -g "${var}"="$PROMPT_GIT_DIRTY_SYMBOL"
    fi
}

prompt_clear_screen() {
    # enable output to terminal
    zle -I

    # clear screen and move cursor to (0,0)
    print -n '\e[2J\e[0;0H'

    # print preprompt
    _prompt_preprompt_render
}

_prompt_set_title() {
    # tell the terminal we're setting the title
    print -n '\e]0;'

    # show hostname if connected through SSH
    [[ -n $SSH_CONNECTION ]] && print -Pn '(%m) '
    case $1 in
        expand-prompt)
            print -Pn $2;;
        ignore-escape)
            print -rn $2;;
    esac

    # end title
    print -n '\a'
}

preexec() {
    prompt_cmd_timestamp=$EPOCHSECONDS

    # show the current dir and executed command in title while a process
    # is active
    _prompt_set_title 'ignore-escape' "$PWD:t: $2"
}

_prompt_preprompt_render() {
    # username and hostname, if using SSH connection
    local preprompt="${prompt_username} "

    # path
    preprompt+="%F{$PROMPT_PATH_COLOUR}%~%f"

    # git info
    preprompt+="%F{$PROMPT_GIT_COLOUR}${vcs_info_msg_0_}${prompt_git_dirty}%f"

    # execution time
    preprompt+="%F{$PROMPT_EXEC_TIME_COLOUR}${prompt_cmd_exec_time}%f"

    print -P "\n${preprompt}"
}

precmd() {
    # check exec time and store it in a variable
    _prompt_check_cmd_exec_time

    # check git dirty status and store it in a variable
    _prompt_git_dirty_to_var 'prompt_git_dirty'

    # show full path in the title
    _prompt_set_title 'expand-prompt' '%~'

    # get vcs info
    vcs_info

    # print the preprompt
    _prompt_preprompt_render
}

_prompt_setup() {
    zmodload zsh/datetime
    zmodload zsh/zle

    # Add custom clear-screen function
    zle -N clear-screen prompt_clear_screen

    # Use vcs_info to get git branch, dirty state, etc
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' use-simple true
    zstyle ':vcs_info:*' max-exports 2
    zstyle ':vcs_info:git*' formats ' %b' 'x%R'
    zstyle ':vcs_info:git*' actionformats ' %b|%a' 'x%R'

    if [[ $UID -eq 0 ]]; then
        # If root, show username in different colour
        prompt_username="%F{$PROMPT_ROOT_COLOUR}%n%f"
    else
        prompt_username="%F{$PROMPT_USER_COLOUR}%n%f"
    fi

    if [[ "$SSH_CONNECTION" != '' ]]; then
        # Show hostname if logged in through SSH
        prompt_username+="%F{$PROMPT_HOST_COLOUR}@%m%f"
    fi

    # Prompt changes colour if the previous command didn't exit with 0
    PROMPT="%(?.%F{$PROMPT_SYMBOL_COLOUR}.%F{$PROMPT_SYMBOL_NON_ZERO_COLOUR})"
    PROMPT+="${PROMPT_SYMBOL}%f "
}

_prompt_setup
