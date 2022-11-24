#!/usr/bin/bash


wallpaper=`ls -1 /home/maren/.dotfiles/wallpaper | rofi -dmenu -theme /home/maren/.config/rofi/rofi.rasi ` 

echo $wallpaper


if [ "$wallpaper" == "" ]; then 

wallpaper="cyberpunk2.jpg"
fi


while getopts ld option
do
  case "${option}"
    in

    l) 
      #echo wal -l -i /home/maren/.dotfiles/wallpaper/$wallpaper 
      #wal -l -i /home/maren/.dotfiles/wallpaper/$wallpaper 

      ~/.local/bin/collection/extractor.sh /home/maren/.dotfiles/wallpaper/$wallpaper light
wal --theme ~/.dotfiles/scripts/.local/bin/collection/data/colorscheme.json
    ;;
    d)
      #echo wal -i /home/maren/.dotfiles/wallpaper/$wallpaper  
      #wal -i /home/maren/.dotfiles/wallpaper/$wallpaper  
      ~/.local/bin/collection/extractor.sh /home/maren/.dotfiles/wallpaper/$wallpaper
wal --theme ~/.dotfiles/scripts/.local/bin/collection/data/colorscheme.json
    ;;
esac
done

      /home/maren/.local/bin/collection/rofiThemeGenerator.sh
      #/home/maren/.local/bin/collection/awesomeThemeGenerator.sh
      /home/maren/.local/bin/collection/polybarThemegenerator.sh
      # /home/maren/.local/bin/collection/xmobarThemeGenerator.sh
      /home/maren/.local/bin/collection/starshipThemeGenerator.sh
      /home/maren/.local/bin/collection/lualineThemeGenerator.sh
      /home/maren/.local/bin/collection/tmuxThemeGenerator.sh

# qutebrowser :config-source

feh --bg-fill /home/maren/.dotfiles/wallpaper/$wallpaper
