#!/bin/bash
parentTicket="$1"
sed -e "s/STORYID/$parentTicket/g" /home/maren/dotfiles/vim/template/SubtaskReviseDocs.yml > /tmp/SubtaskReviseDocs.yml 
sed -e "s/STORYID/$parentTicket/g" /home/maren/dotfiles/vim/template/SubtaskDeployDev.yml > /tmp/SubtaskDeployDev.yml 
sed -e "s/STORYID/$parentTicket/g" /home/maren/dotfiles/vim/template/SubtaskDeployStage.yml > /tmp/SubtaskDeployStage.yml 
sed -e "s/STORYID/$parentTicket/g" /home/maren/dotfiles/vim/template/SubtaskPeer_Review.yml > /tmp/SubtaskPeer_Review.yml 
sed -e "s/STORYID/$parentTicket/g" /home/maren/dotfiles/vim/template/SubtaskImplement.yml > /tmp/SubtaskImplement.yml 
sed -e "s/STORYID/$parentTicket/g" /home/maren/dotfiles/vim/template/SubtaskPeer_Migration.yml > /tmp/SubtaskMigration.yml 

jira subtask $parentTicket -t /tmp/SubtaskDeployStage.yml --noedit
jira subtask $parentTicket -t /tmp/SubtaskDeployDev.yml --noedit
jira subtask $parentTicket -t /tmp/SubtaskPeer_Review.yml --noedit
jira subtask $parentTicket -t /tmp/SubtaskReviseDocs.yml --noedit
jira subtask $parentTicket -t /tmp/SubtaskImplement.yml --noedit
# jira subtask $parentTicket -t /tmp/SubtaskMigration.yml --noedit

