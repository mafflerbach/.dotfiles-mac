#!/bin/bash

ARR=()
ARR+=("Lock")
ARR+=("Suspend")
ARR+=("Shutdown")

choice="$(printf '%s\n' "${ARR[@]}" | choose )"

if [ "$choice" == "Shutdown" ]
then
    shutdown now
fi

if [ "$choice" == "Suspend" ]
then
    pmset sleepnow
fi

if [ "$choice" == "Lock" ]
then
    pmset displaysleepnow
fi

if [ "$choice" == "Reboot" ]
then
    reboot
fi
