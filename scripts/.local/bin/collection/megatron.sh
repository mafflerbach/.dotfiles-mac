#!/bin/bash

FQSN=`cat $HOME/dotfiles/scripts/data/fqsn | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi ` 
qutebrowser "https://int-ci-d01.sixt.de/jenkins/megatron/job/Solution/job/Deployment/job/$FQSN/build"
https://int-ci-d01.sixt.de/jenkins/megatron/job/Solution/job/Deployment/job/PROD/job/com.sixt.bi.datashop_event_forwarder/
