#!/bin/bash

service=$(ls -1 /home/maren/development  | grep 'service\|job' | fzf)
env=$(echo -e "dev\r\nstage\r\nprod" | fzf)

git_dir="/home/maren/development/$service/.git"
work_tree="/home/maren/development/$service"

commit=$(git --git-dir="$git_dir" --work-tree="$work_tree" log | head -n1 | sed -e 's/commit //')

echo "@cibot deploy $service $commit to $env"
