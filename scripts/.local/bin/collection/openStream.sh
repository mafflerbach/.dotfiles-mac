#!/bin/bash
selection=`cat ~/dotfiles/scripts/data/linkList | cut -d' ' -f1  | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi ` 
echo $selection

streamLink=$(grep $selection ~/dotfiles/scripts/data/linkList | cut -d' ' -f2)
mpv $streamLink &
