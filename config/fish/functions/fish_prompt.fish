function fish_prompt -d "Display the terminal prompt"
    # Cache exit status from last command
    set -l __last_status $status

    # Set char, based on current user
    if not set -q __fish_prompt_char
        switch (id -u)
            case 0
                set -g __fish_prompt_char $__fish_prompt_char_root
            case '*'
                set -g __fish_prompt_char $__fish_prompt_char_user
        end
    end

    # Grab normal color
    set -l normal (set_color normal)

    # Add newline before prompt
    echo -e ''

    # Display working directory
    echo -n -s (set_color $__fish_prompt_color_path) (pwd | sed "s|^$HOME|~|") $normal

    # Display git prompt
    __fish_git_prompt ":%s"

    # Display [venv] if in a virtualenv (on a new line, before prompt char)
    echo -e ''
    if set -q VIRTUAL_ENV
        echo -n -s (set_color $__fish_prompt_color_venv) '[' (basename "$VIRTUAL_ENV") ']' $normal ' '
    end

    # Display prompt character (in red if previous command had non-zero exit status)
    if test $__last_status -ne 0
        echo -e -n -s (set_color $__fish_prompt_color_char_error) $__fish_prompt_char $normal ' '
    else
        echo -e -n -s (set_color $__fish_prompt_color_char) $__fish_prompt_char $normal ' '
    end
end
