#!/bin/bash

alpha=ff

colors=$(yq e '.colors' ~/.cache/wal/colors.yml)

cp /home/maren/dotfiles/rofi/colors-rofi-template.rasi /tmp/rofi.rasi

while IFS= read -r line ; do 

    line=$(echo $line | tr a-z A-Z)
    line=${line//:/}
    line=${line//\"/}
    color=$(echo $line | cut -f1 -d" ")
    hex=$(echo $line | cut -f2 -d" ")

sed -i "s/$color/$hex$alpha/g" /tmp/rofi.rasi


done <<< "$colors"

background=$(yq e '.special.background' ~/.cache/wal/colors.yml )
foreground=$(yq e '.special.foreground' ~/.cache/wal/colors.yml )
sed -i "s/BGCOLOR/$background$alpha/g" /tmp/rofi.rasi
sed -i "s/FGCOLOR/$foreground/g" /tmp/rofi.rasi

mv /tmp/rofi.rasi /home/maren/.config/rofi/rofi.rasi



