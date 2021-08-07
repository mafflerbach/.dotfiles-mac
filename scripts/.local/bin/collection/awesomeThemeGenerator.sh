#!/bin/bash

alpha=99

colors=$(yq e '.colors' ~/.cache/wal/colors.yml)
i=0

cp /home/maren/.dotfiles/awesome/.config/awesome/theme.template.lua /tmp/theme.lua

while IFS= read -r line ; do 

    line=$(echo $line | tr a-z A-Z)
    line=${line//:/}
    line=${line//\"/}
    color=$(echo $line | cut -f1 -d" ")
    hex=$(echo $line | cut -f2 -d" ")

sed -i "s/$color/$hex$alpha/g" /tmp/theme.lua
echo "replace $color $hex$alpha"

magick convert /home/maren/.dotfiles/awesome/.config/awesome/icons/display/mask-right.png  -alpha set  -channel RGBA \
  -fuzz 50%  -fill "$hex$alpha" -opaque black /home/maren/.dotfiles/awesome/.config/awesome/icons/display/$i-l.png \
  -fuzz 50%  -fill "$hex$alpha" -opaque black /home/maren/.dotfiles/awesome/.config/awesome/icons/display/$i-l.png

echo "generate $i-l.png"
magick convert /home/maren/.dotfiles/awesome/.config/awesome/icons/display/mask-left.png  -alpha set  -channel RGBA \
 -fuzz 50% -fill "$hex$alpha" -opaque white   /home/maren/.dotfiles/awesome/.config/awesome/icons/display/$i-r.png
echo "generate $i-r.png"

((i++))
echo ""
done <<< "$colors"

background=$(yq e '.special.background' ~/.cache/wal/colors.yml )
foreground=$(yq e '.special.foreground' ~/.cache/wal/colors.yml )
wallpaper=$(cat ~/.cache/wal/wal)

sed -i "s#WALLPAPER#$wallpaper#g" /tmp/theme.lua
sed -i "s/BGCOLOR/$background/g" /tmp/theme.lua
sed -i "s/FGCOLOR/$foreground/g" /tmp/theme.lua

colorGrad1=$(yq e '.colors.color2' ~/.cache/wal/colors.yml )
colorGrad2=$(yq e '.colors.color4' ~/.cache/wal/colors.yml )

$HOME/.local/bin/collection/generateIcons.sh "$colorGrad1" "$colorGrad2"

cp /tmp/theme.lua $HOME/.config/awesome/theme.lua
echo 'awesome.restart()' | awesome-client
