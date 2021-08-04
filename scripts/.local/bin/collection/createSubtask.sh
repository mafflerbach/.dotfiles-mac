#!/bin/bash

sed -e "s/STORYID/$1/g" /home/maren/.jira.d/templates/jiraSubtask.yml > /tmp/Subtask.yml 
jira subtask $1 -t /tmp/Subtask.yml  


