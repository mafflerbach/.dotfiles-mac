#!/bin/bash
targetDisplay=$1

#currentSpace=$(yabai -m query --windows --space $(yabai -m query --spaces --space | jq '.index' ) | jq '.[].id')
currentSpace=$(yabai -m query --windows --space   | jq '.[].id')
targetSpace=$(yabai -m query --windows --display $targetDisplay  | jq '.[].id')

currentDisplay=$(yabai -m query --displays --display | jq '.index' )
# targetDisplay=$(yabai -m query --displays --display)

for id in $currentSpace; do 
    yabai -m window $id --display $targetDisplay
done

for id in $targetSpace; do 
    yabai -m window $id --display $currentDisplay
done





