#!/bin/bash

repo=$(gh repo view | head -n1 | cut -d"	" -f2)
path=$1
line=$2
branch=$(git branch | grep \* | cut -d ' ' -f2)
url="https://github.com/$repo/blob/$branch/$path#L$line"
echo $url | xsel --clipboard --input

