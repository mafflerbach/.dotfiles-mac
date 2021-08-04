#!/bin/bash

if [ !"$(find 'data/topicList' -ctime +7)" ]; then
    echo "fetch topicList"
curl 'https://kafka-manager-dev.goorange.sixt.com/clusters/kafka-dev/topics' --compressed > /tmp/out.html
fi

echo "cat //table/tbody/tr/td//a" |  xmllint --html --shell /tmp/out.html | sed '/^\/ >/d' | sed '/-------/d'|sed 's/<[^>]*.//g' > data/topicList

topic=$(cat data/topicList | fzf)

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
content="["$tmpC"]"

env=$(echo -e "dev\r\nstage" | fzf)

echo "Play message $fileName on $topic via support api"

# TODO env testing
auth="Authorization: Basic "$(pass show Sixt/supportapi/$env | head -n1)
curl --location --request POST 'http://localhost:9090/api/support/'$topic'/replay' \
--header "$(echo $auth)" \
--header 'Content-Type: application/json' \
-d "$(echo $content)"

if [ "$env" == "stage" ]; then
    curl --location --request POST 'http://localhost:9091/api/support/'$topic'/replay' \
    --header "$(echo $auth)" \
    --header 'Content-Type: application/json' \
    -d "$(echo $content)"
fi


