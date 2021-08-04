#!/bin/bash

cp /home/maren/dotfiles/vim/colorsTemplate.vim /tmp/colors.vim
colors=$(yq e '.colors' ~/.cache/wal/colors.yml)

while IFS= read -r line ; do 

    line=$(echo $line | tr a-z A-Z)
    line=${line//:/}
    line=${line//\"/}
    color=$(echo $line | cut -f1 -d" ")
    hex=$(echo $line | cut -f2 -d" ")

    echo $hex
    echo $color

sed -i "s/\"$color\"/\"$hex\"/g" /tmp/colors.vim

done <<< "$colors"

mv /tmp/colors.vim /home/maren/dotfiles/vim/colors.vim


