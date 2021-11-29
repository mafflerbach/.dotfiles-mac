#!/usr/bin/env zsh

sessions=$(tmux list-panes -a -F "#S	#I	#P	#T" ) 

#session=$(echo -e $sessions | cut -d"	" -f2)

#foo=$(echo -e $sessions | fzf )
#
#session=$(echo -e $foo | cut -d"	" -f1)
#window=$(echo -e $foo | cut -d"	" -f2)
#pane=$(echo -e $foo | cut -d"	" -f3)
#paneTitle=$(echo -e $foo | cut -d"	" -f4)

echo  $sessions

#tmux switch -t $session:$window


