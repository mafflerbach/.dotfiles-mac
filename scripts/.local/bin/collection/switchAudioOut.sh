#!/bin/bash


while :; do
    case "$1" in
        -m) 
            SwitchAudioSource -s "$(SwitchAudioSource -a -t input | choose)"
            ;;
        -o) 
            SwitchAudioSource -s "$(SwitchAudioSource -a -t output | choose)"
            ;;
        *)
            break
    esac
    shift
done
