#!/bin/zsh

#FQSN=`ls -1 /home/maren/development | rofi -dmenu -theme ~/dotfiles/i3/rofi.rasi ` 
#echo "export FQSN=$FQSN" > /home/maren/exportedVars 
#echo $FQSN | xsel --clipboard --input

devDir=$(ls -1t /Users/maren/development)
solutionsDir=$(ls -1t  /Users/maren/development)

FQSN=$(echo -e $devDir"\n"$solutionsDir |  choose -u )
clean_name=$(echo $FQSN | tr "./" "__")
session_name=$(tmux display-message -p "#S")
target="$session_name:$clean_name"

if ! tmux has-session -t $target 2> /dev/null; then 
tmux neww -n $clean_name 
tmux send-keys -t $clean_name "openproject.sh $FQSN "
fi
tmux split-window -l 15

   checkoutName="$FQSN"
tmux send-keys -t $clean_name "cd ~/development/$checkoutName "
tmux select-pane -t 0


