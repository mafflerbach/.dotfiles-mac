#!/bin/bash

env=$(echo -e "DEV\nSTAGE\nPROD" | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi)

FQSN=`exa -1 --no-icons ~/development/solutions.common.configuration/src | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi ` 
qutebrowser "https://int-ci-d01.sixt.de/jenkins/megatron/job/Solution/job/Deployment/job/$env/job/$FQSN/build"


