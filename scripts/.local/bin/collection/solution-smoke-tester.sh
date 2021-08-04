#!/bin/bash

function join_by { local d=$1; shift; local f=$1; shift; printf %s "$f" "${@/#/$d}"; }

FQSN=`ls -1 /home/maren/development/solutions.common.configuration/src | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi ` 
FQSN=${FQSN//\-/_}

result=($(rg queue ~/development/solutions.common.configuration/src/$FQSN))
pattern="~/development/solutions.common.configuration/src/$FQSN/solution-conf/"

typeset -i i=0 max=${#result[*]}
while (( i < max ))
do
    property=${result[$i]/$pattern/}
    property=${property//*=/}
    queues[$i]=$property
    i=i+1
done

queueList=$( IFS=$'\n'; echo "${queues[*]}" )
queueName=$(echo "$queueList" | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi)

files=($(find "/home/maren/development/solutions.java.$FQSN/src/test/resources/data"))

pattern="/home/maren/development/solutions.java.$FQSN/src/test/resources/data"
typeset -i i=0 max=${#files[*]}
while (( i < max ))
do
    path=${files[$i]//$pattern/}
    pathList[$i]=$path
    i=i+1
done

sep="\n" # can be of any length
bar=$(printf "${sep}%s" "${pathList[@]}")
pathList=${bar:${#sep}}
fileName=$pattern$(echo "$pathList" | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi)

cd /home/maren/development/solutions.utils.smoke_tester/
STAGE=1 cargo run $FQSN $queueName "$fileName"
# cargo run $FQSN $queueName "$fileName"

#cargo run $FQSN $queueName "$fileName"

#./smoke_tester com.sixt.db.archiving com.sixt.db.archiving.PaymentObject.mirror "/home/maren/development/solutions.java.com.sixt.db.archiving/src/test/resources/data/archiving_event.json" | vim -
