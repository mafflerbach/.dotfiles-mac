#!/bin/bash
internalKeb=$(xinput list | grep 'AT Translated Set' | cut -f2 | cut -d'=' -f2)
touchpad=$(xinput list | grep 'TouchPad' | cut -f2 | cut -d'=' -f2)

if [ "$1" == "true" ] ; then 
    xinput float $internalKeb
    xinput float $touchpad
fi

if [ "$1" == "false" ] ; then 
    xinput reattach $internalKeb 3
    xinput reattach $touchpad 2
fi



