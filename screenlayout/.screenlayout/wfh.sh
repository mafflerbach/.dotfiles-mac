#!/bin/sh
xrandr --output DP1-2-8 --mode 1920x1080 --pos 1920x0 --rotate normal 

xrandr --output DP1-1 --mode 1920x1080 --pos 0x0 --rotate normal 

xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x1080 --rotate normal --below DP1-1
