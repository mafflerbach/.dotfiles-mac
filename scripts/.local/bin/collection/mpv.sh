#!/usr/bin/env bash

while getopts rs option
do
    case "${option}"
        in
        s) 
            echo '{ "command": ["set_property", "pause", true] }' | socat - /tmp/mpvsocket
        ;;
        r)
            echo '{ "command": ["set_property", "pause", false] }' | socat - /tmp/mpvsocket
        ;;
esac
done




