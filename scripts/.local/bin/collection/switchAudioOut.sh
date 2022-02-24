#!/bin/bash

SINK=$(pactl list short sinks | rofi -dmenu -theme /home/maren/.config/rofi/rofi.rasi)
NEW_SINK=$(echo $SINK | cut -f2)
pactl set-default-sink "$NEW_SINK"

exit 0


INPUT=$(pactl list short sources | rofi -dmenu -theme /home/maren/.config/rofi/rofi.rasi)
NEW_OUTPUT=$(echo $INPUT | cut -f2)
pactl set-default-source "$NEW_OUTPUT"
