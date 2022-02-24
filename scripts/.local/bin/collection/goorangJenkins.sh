#!/bin/bash

FQSN=`exa -1 --no-icons ~/development | grep service | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi ` 


https://ci.goorange.sixt.com/jenkins/api/json?pretty=true
qutebrowser "https://ci.goorange.sixt.com/job/INTS/job/$FQSN/job/master"

https://ci.goorange.sixt.com/job/INTS/api/xml?xpath=/*/*[0]


https://ci.goorange.sixt.com/api/xml


