#!/bin/bash

while :; do
    case "$1" in
        -c) 
            scutil --nc start 520B37A7-2FE1-4D5E-814F-411301660B6F
            ;;
        -k) 
            # reactivate wifi connection for the case, that i want to detach from my docking station later

            scutil --nc stop 520B37A7-2FE1-4D5E-814F-411301660B6F

            ;;
        *)
            break
    esac
    shift
done
