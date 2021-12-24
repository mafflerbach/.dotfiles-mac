#!/bin/zsh

FQSN=`ls -1 /home/maren/development/solutions.common.configuration.dev/src | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi ` 

echo "export FQSN=${FQSN//\-/_}" > /home/maren/exportedVars 
echo ${FQSN//\-/_} | xsel --clipboard --input


