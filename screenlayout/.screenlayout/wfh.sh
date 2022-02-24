#!/bin/sh
xrandr --output eDP1 --mode 1920x1080 --pos 1920x1080 --rotate normal --below DP1-1-8 \
       --output DP1-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --left-of DP1-1-8\

sleep 2
xrandr --output eDP1 --mode 1920x1080 --pos 1920x1080 --rotate normal --below DP1-1-8 \
       --output DP1-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --left-of DP1-1-8\
       --output DP1-1-8 --mode 1920x1080 --pos 1920x0 --rotate normal --right-of DP1-1-1

