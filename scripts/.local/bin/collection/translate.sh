#!/usr/bin/env bash

input=$(echo -e "off\r\non\r\nrainbow\r\n"| rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi ) 

if [ "$input" != "" ]; then 

    while getopts de option
    do
        case "${option}"
            in
            e) 
            qutebrowser "https://translate.google.com/?hl=en#view=home&op=translate&sl=de&tl=en&text=$input"
            ;;
        d)
            qutebrowser "https://translate.google.com/?hl=de#view=home&op=translate&sl=en&tl=de&text=$input"
            ;;
        esac
    done

fi
