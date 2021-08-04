#!/bin/bash


while :; do
    case "$1" in
        -df) 
            echo $(df -h / | tail -n1 | sed -e"s/  / /g" | cut -d" " -f5)/$(df -h / | tail -n1 | sed -e"s/  / /g" | cut -d" " -f6)
            ;;
        -watson) 
            echo $(watson log | head -n1) / $(watson status | sed -e "s/Project //g" -e "s/(.*)//g")
            ;;

        *)
            break
    esac
    shift
done
