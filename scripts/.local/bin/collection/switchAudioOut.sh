#!/bin/bash


while :; do
    case "$1" in
        -m) 

            INPUT=$(pactl list short sources | rofi -dmenu -theme /home/maren/.config/rofi/rofi.rasi)
            NEW_INPUT=$(echo $INPUT | cut -f2)
            pactl set-default-source "$NEW_INPUT"

            ;;
        -o) 

            SINK=$(pactl list short sinks | rofi -dmenu -theme /home/maren/.config/rofi/rofi.rasi)
            NEW_SINK=$(echo $SINK | cut -f2)
            pactl set-default-sink "$NEW_SINK"

            ;;
        *)
            break
    esac
    shift
done
