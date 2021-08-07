#!/bin/bash


input=$(rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi | xargs) 

if [ "$input" != "" ]; then 
    mpv $input

fi
