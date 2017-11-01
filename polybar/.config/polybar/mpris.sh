#!/bin/bash

icon=""
colour_playing="" # Use default
colour_paused="%{F#969896}"

player_status=$(playerctl status 2> /dev/null)
if [[ $? -eq 0 ]]; then
    metadata="$(playerctl metadata artist) - $(playerctl metadata title)"
fi

if [[ $player_status = "Playing" ]]; then
    echo "$colour_playing$icon $metadata"
elif [[ $player_status = "Paused" ]]; then
    echo "$colour_paused$icon $metadata"
fi
