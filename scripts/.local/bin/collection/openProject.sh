#!/bin/zsh

#FQSN=`ls -1 /home/maren/development | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi ` 
echo "export FQSN=$FQSN" > /home/maren/exportedVars 
echo $FQSN | xsel --clipboard --input

#FQSN=`ls -1 /home/maren/development/solutions.common.configuration/src | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi ` 

devDir=$(ls -1t /home/maren/development)
solutionsDir=$(ls -1 /home/maren/development/solutions.common.configuration/src)

FQSN=$(echo -e $devDir"\n"$solutionsDir |  rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi)

if [ -d ~/development/$FQSN ]; then
    cd ~/development/$FQSN
    nvim
else 
    cd ~/development
   checkoutName="solutions.java.$FQSN"
    gh repo clone "Sixt-Int/$checkoutName"
    if [ -d ~/development/$checkoutName ]; then
        cd ~/development/$checkoutName
        nvim
    fi
fi

zsh

