#!/bin/bash

if [ $1 == "play" ]; then
    echo "play mpv"
    mpv --playlist=/tmp/playlist --input-ipc-server=/tmp/mpvsocket --demuxer-max-bytes=1G
    rm -f /tmp/playlist
fi 

if [ $1 == "playloop" ]; then

    while read link; do
        youtube-viewer --resolution=1080p --player=mpv --no-interactive $link
    done < /tmp/playlist

    rm -f /tmp/playlist
fi 


if [ $1 == "push" ]; then
    echo $2 >> /tmp/playlist
fi 

