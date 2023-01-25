#!/bin/bash

selection=`cat /Users/maren/.local/bin/collection/data/applicationList | cut -d'|' -f1  | choose` 
echo $selection
if [ -n "$selection" ]; then 
command=$(grep "$selection" /Users/maren/.local/bin/collection/data/applicationList | head -n 1 | cut -d'|' -f2)
echo $command
eval $command
fi

