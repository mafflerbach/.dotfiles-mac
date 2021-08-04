#!/bin/bash


function getTopic() {
    url="https://kafka-manager-dev.goorange.sixt.com/clusters/kafka-dev/topics"
    if [ "$ENV"=="stage" ]; then 
        url="https://kafka-manager-stage.goorange.sixt.com/clusters/stage/topics"
    fi


    curl "$url" --compressed > /tmp/out.html
    echo "cat //table/tbody/tr/td//a" |  xmllint --html --shell /tmp/out.html | sed '/^\/ >/d' | sed '/-------/d'|sed 's/<[^>]*.//g' > data/topicList

    topic=$(cat data/topicList | fzf)
    echo $topic
}

function getFiles() {


    DIR=`ls -1 /home/maren/development/ | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi ` 

    files=($(find "/home/maren/development/$DIR/src/jbehave/resources/data"))

    pattern="/home/maren/development/$DIR/src/jbehave/resources/data"
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

    tmpC=$(cat $(echo $fileName) | tr '\n' ' ')
    foo=${tmpC//\"/\\\"}
    content="[{\"headers\": {},\"payload\": \"$foo\" } ]"
    echo $content
}

function getService() {
    services=$(kubectl get pod -o jsonpath='{.items[*].spec.containers[].name}') 
    servicePod=$(echo -e ${services// /\\n} | fzf)
    service=${servicePod/com-sixt-service-/}
    echo $service
}

ENV=$(echo -e "dev\nstage" | fzf)
topic=$(getTopic)
service=$(getService)
content=$(getFiles)

#if [ "$topic"=="" ] || [ "$service"=="" ] || [ "$content"=="" ]; then
#exit
#fi

serviceurl="https://api-dev.goorange.sixt.com/v1/$service/support/rest/error-topics/$topic/kafka-topic-consumer/messages?ignoreHeaders=true"
if [ "$ENV"=="stage" ]; then 
    serviceurl="https://api-stage.goorange.sixt.com/v1/$service/support/rest/error-topics/$topic/kafka-topic-consumer/messages?ignoreHeaders=true"
fi

pass=$(pass Sixt/supportapi/$ENV)

curl --location --request POST "$serviceurl" \
    --header "Authorization: Basic $pass" \
    --header 'Content-Type: application/json' \
    -d "$(echo $content)"




