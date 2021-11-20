#!/usr/bin/bash


wallpaper=`ls -1 /home/maren/.dotfiles/wallpaper | rofi -dmenu -theme /home/maren/.config/rofi/rofi.rasi ` 


while getopts ld option
do
  case "${option}"
    in

    l) 
      echo wal -l -i /home/maren/.dotfiles/wallpaper/$wallpaper 
      wal -l -i /home/maren/.dotfiles/wallpaper/$wallpaper 

    ;;
    d)
      echo wal -i /home/maren/.dotfiles/wallpaper/$wallpaper  
      wal -i /home/maren/.dotfiles/wallpaper/$wallpaper  
    ;;
esac
done

      /home/maren/.local/bin/collection/rofiThemeGenerator.sh
      /home/maren/.local/bin/collection/awesomeThemeGenerator.sh
      /home/maren/.local/bin/collection/tmuxThemeGenerator.sh
qutebrowser :config-source
#      /home/maren/dotfiles/scripts/xmobarThemeGenerator.sh


feh --bg-center /home/maren/.dotfiles/wallpaper/$wallpaper
