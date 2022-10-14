#!/bin/bash


input=$(echo -e "off\non\nrainbow\naurora\ncyberpunk\nwhite\nblue and pink\nviolete and orange"| rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi ) 
echo $input

if [ "$input" == "on" ]; then 
    curl -X POST "http://192.168.0.127/json/state" -d '{"on":true}' -H "Content-Type: application/json"
fi

if [ "$input" == "off" ]; then 
    curl -X POST "http://192.168.0.127/json/state" -d '{"on":false}' -H "Content-Type: application/json"
fi

if [ "$input" == "rainbow" ]; then 
    curl -X POST "http://192.168.0.127/json/state" -d '{"ps":5}' -H "Content-Type: application/json"
fi
if [ "$input" == "cyberpunk" ]; then 
    curl -X POST "http://192.168.0.127/json/state" -d '{"ps":1}' -H "Content-Type: application/json"
fi


if [ "$input" == "white" ]; then 
    curl -X POST "http://192.168.0.127/json/state" -d '{"ps":2}' -H "Content-Type: application/json"
fi

if [ "$input" == "blue and pink" ]; then 
    curl -X POST "http://192.168.0.127/json/state" -d '{"ps":4}' -H "Content-Type: application/json"
fi

if [ "$input" == "violete and orange" ]; then 
    curl -X POST "http://192.168.0.127/json/state" -d '{"ps":3}' -H "Content-Type: application/json"
fi

