#!/bin/zsh
fqsnClip=$(xclip -selection c -o)
echo $fqsnClip
FQSN=`grep -Roh "queue.*${fqsnClip}.*error" /home/maren/development/solutions.common.configuration/src  | cut -d'=' -f2  | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi ` 
echo "export FQSN=$FQSN" > /tmp/errorQueue
echo $FQSN | xsel --clipboard --input


