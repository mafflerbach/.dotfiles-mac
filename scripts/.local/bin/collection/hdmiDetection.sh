#!/bin/sh

hdmi_interfaces = $(ls -d /sys/class/drm/card0/*HDMI*)

for i in $hdmi_interfaces ; do
    if [ "$(cat $i/status)" = "connected" ]; then
        echo "Switching to HDMI audio."
        pactl set-card-profile 0 'output:hdmi-stereo'
        exit
    fi
done

echo "Switching to internal audio."
pactl set-card-profile 0 'output:analog-stereo+input:analog-stereo'

xset s off -dpms
