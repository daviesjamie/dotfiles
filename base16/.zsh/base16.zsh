export BASE16_SHELL="$HOME/.config/base16-shell"
export BASE16_THEME_FILE="$HOME/.base16_theme"

function _source_base16_theme {
    local script="$BASE16_SHELL/scripts/base16-$1.sh"

    if [[ -s "$script" ]]; then
        export BASE16_THEME="$1"
        echo "export BASE16_THEME='$1'" >| $BASE16_THEME_FILE
        source $script
    else
        echo "$script is not a valid theme" 1>&2
        return 1
    fi
}

# Load $BASE16_THEME from ~/.base16_theme, if it exists
[[ -f "$HOME/.base16_theme" ]] && source $BASE16_THEME_FILE

# Set a default for $BASE16_THEME
[[ -z "$BASE16_THEME" ]] && export BASE16_THEME="tomorrow-night"

# Load base16 colourscheme
_source_base16_theme $BASE16_THEME
