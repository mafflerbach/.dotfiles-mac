#!/bin/bash
path=/home/maren/.dotfiles/awesome/.config/awesome/icons/bar
# generate gradient

magick -size 100x100 -define gradient:angle=45 gradient:$1-$2 $path/../linear_gradient.png  
rm $path/*-icon*

for file in $path/*.png ; do 
    echo ${file/\.png/}-icon.png
    convert $file $path/../linear_gradient.png  $file -composite ${file/\.png/}-icon.png

    convert ${file/\.png/}-icon.png -background none  \
        \( +clone   -background black   -shadow 100x2+2+2 \) +swap \
        -background none   -layers merge +repage  ${file/\.png/}-icon.png

    convert ${file/\.png/}-icon.png -background none  \
        \( +clone   -background white   -shadow 100x2-2-2 \) +swap \
        -background none   -layers merge +repage  ${file/\.png/}-icon.png

done


