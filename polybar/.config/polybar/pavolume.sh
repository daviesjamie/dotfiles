#!/usr/bin/env bash

# Icons
icon_normal=""
icon_muted=""

# Colours
colour_normal="" # Use default
colour_muted="%{F#969896}"

# STATE
muted='no'
active_sink=''
cur_vol=''

# Get the current volume
get_current_volume() {
    cur_vol=$(pacmd list-sinks \
        | grep -A 15 "index: $active_sink$" \
        | grep 'volume:' \
        | grep -E -v 'base volume:' \
        | awk -F : '{print $3}' \
        | grep -o -P '.{0,3}%' \
        | sed s/.$// | tr -d ' ' \
    )
}

# Get the currently active sink
get_current_sink() {
    active_sink=$(pacmd list-sinks | awk '/\* index:/{print $3}')
}

# Get the mute status
get_mute_status() {
    muted=$(pacmd list-sinks | grep -A 15 "index: $active_sink$" | awk '/muted/{print $2}')
}

# Listen for changes and immediately create new output for the bar
# This is faster than having the script refresh on an interval
listen() {
    # Output the initial state
    output

    # Subscribe to new events and generate new output when there are events
    pactl subscribe 2>/dev/null | {
        while true; do
            {
                read -r event || break
                if ! echo "$event" | grep -e "on card" -e "on sink"; then
                    # Avoid double events
                    continue
                fi
            } &>/dev/null
            output
        done
    }
}

# Collect all the information and generate output
output() {
    get_current_sink
    get_current_volume
    get_mute_status

    if [[ "$muted" = 'yes' ]]; then
        echo "$colour_muted$icon_muted MUTE"
    elif [[ "$cur_vol" -eq "0" ]]; then
        echo "$colour_muted$icon_muted $cur_vol%"
    else
        echo "$colour_normal$icon_normal $cur_vol%"
    fi
}

# The main entry point for the script
main() {
    case "$1" in
        --listen)
            listen
            ;;
        *)
            output
            ;;
    esac
}

main "$@"
