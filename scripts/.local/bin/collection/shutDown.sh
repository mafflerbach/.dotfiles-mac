#!/bin/bash


export DISPLAY=:0
export XAUTHORITY=/home/maren/.Xauthority
ARR=()
ARR+=("Lock")
ARR+=("Monitor")
ARR+=("Suspend")
ARR+=("Reboot")
ARR+=("Exit")
ARR+=("Shutdown")

CHOICE="$(printf '%s\n' "${ARR[@]}" | rofi -dmenu -config $HOME/.config/rofi/rofi.rasi -p " Power")"

if [ "$CHOICE" == "Shutdown" ]
then
    shutdown now
fi


if [ "$CHOICE" == "Monitor" ]
then
    xset dpms force off
fi

if [ "$CHOICE" == "Suspend" ]
then
    bash /home/maren/.dotfiles/scripts/.local/bin/collection/lock.sh 
    systemctl suspend
fi

if [ "$CHOICE" == "Lock" ]
then
    bash /home/maren/.dotfiles/scripts/.local/bin/collection/lock.sh 
fi
if [ "$CHOICE" == "Exit" ]
then
    i3-msg exit
fi
if [ "$CHOICE" == "Reboot" ]
then
    reboot
fi
