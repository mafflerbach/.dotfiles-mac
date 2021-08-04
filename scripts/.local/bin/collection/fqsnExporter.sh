#!/bin/zsh

FQSN=`ls -1 /home/maren/development | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi ` 


echo "export FQSN=${FQSN//\-/_}" > /home/maren/exportedVars 
echo ${FQSN//\-/_} | xsel --clipboard --input

cd ~/development/$FQSN

zsh

