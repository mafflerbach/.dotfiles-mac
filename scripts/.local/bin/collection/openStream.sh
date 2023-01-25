#!/bin/bash
selection=`cat ~/dotfiles/scripts/data/linkList | cut -d' ' -f1  | choose` 
echo $selection

streamLink=$(grep $selection ~/dotfiles/scripts/data/linkList | cut -d' ' -f2)
mpv $streamLink &
