#!/bin/bash


prNumber=$(gh pr list | tail -n1 | cut -f1)

path=$(gh pr status | head -n2 | tail -n1 | cut -d' ' -f5)

url=https://github.com/$path/pull/$prNumber


echo "Please take a look on the following pr: $url"
