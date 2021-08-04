#!/bin/bash



cp $HOME/.config/tmux/colors.template.conf /tmp/colors.template.conf


background=$(yq e '.colors.color2' ~/.cache/wal/colors.yml )
foreground=$(yq e '.special.foreground' ~/.cache/wal/colors.yml )

sed -i "s/FGCOLOR/$foreground/g" /tmp/colors.template.conf
sed -i "s/BGCOLOR/$background/g" /tmp/colors.template.conf


cp /tmp/colors.template.conf $HOME/.config/tmux/colors.conf

tmux source-file ~/.tmux.conf
