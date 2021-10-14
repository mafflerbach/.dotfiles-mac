#!/bin/zsh

#FQSN=`ls -1 /home/maren/development | rofi -dmenu -theme ~/dotfiles/i3/rofi.rasi ` 
echo "export FQSN=$FQSN" > /home/maren/exportedVars 
echo $FQSN | xsel --clipboard --input

devDir=$(ls -1t /home/maren/development)
solutionsDir=$(ls -1t /home/maren/development/solutions.common.configuration/src)

FQSN=$(echo -e $devDir"\n"$solutionsDir |  rofi -dmenu -theme ~/.config/rofi/rofi.rasi)
clean_name=$(echo $FQSN | tr "./" "__")
session_name=$(tmux display-message -p "#S")
target="$session_name:$clean_name"

if ! tmux has-session -t $target 2> /dev/null; then 
tmux neww -n $clean_name 
tmux send-keys -t $clean_name "openproject.sh $FQSN "
fi



