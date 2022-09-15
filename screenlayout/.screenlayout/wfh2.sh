#!/bin/sh
pkill polybar


xrandr --output eDP1 --mode 1920x1080 --pos 0x1080 --rotate normal \
--newmode "1920x1080R" 138.50  1920 1968 2000 2080  1080 1083 1088 1111 +hsync -vsync \
--output DP1-1-8 --mode 1920x1080 --pos 1920x0 --rotate normal \
--newmode "1920x1080R" 138.50  1920 1968 2000 2080  1080 1083 1088 1111 +hsync -vsync \
--output DP1-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
--newmode "1920x1080R" 138.50  1920 1968 2000 2080  1080 1083 1088 1111 +hsync -vsync \

xmonad --restart
