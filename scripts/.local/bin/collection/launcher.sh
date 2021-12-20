#!/bin/bash

selection=`cat /home/maren/.local/bin/collection/data/applicationList | cut -d'|' -f1  | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi ` 
echo $selection
if [ -n "$selection" ]; then 
command=$(grep "$selection" /home/maren/.local/bin/collection/data/applicationList | head -n 1 | cut -d'|' -f2)
echo $command
eval $command
fi

