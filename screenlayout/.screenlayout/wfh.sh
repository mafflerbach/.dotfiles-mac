#!/bin/sh
pkill polybar


xrandr --output eDP1 --mode 1920x1080 --pos 0x1080 --rotate normal \
--output DP1 --off \
--output DP1-1 --off \
--output DP1-1-1 --off \
--output DP1-1-8 --mode 1920x1080 --pos 1920x0 --rotate normal \
--output DP1-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
--output DP1-3 --off \
--output DP2 --off \
--output HDMI1 --off \
--output VIRTUAL1 --off


xmonad --restart
