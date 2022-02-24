#!/usr/bin/bash


select=$(ls -1 /home/maren/.screenlayout | rofi -dmenu -theme /home/maren/.config/rofi/rofi.rasi)


bash /home/maren/.screenlayout/$select
