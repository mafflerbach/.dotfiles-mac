#!/bin/bash

# example usage. 
# ./runtest.sh com.sixt.service.netquall-transfer

filename=$1

foo=$(pwd)

IFS='/' read -r -a pathArray <<< "$foo"


len=${#pathArray[@]};
file=$( echo ${pathArray[len-1]} | cut -d'.' -f1 )


basepath=$(pwd)
path=$(echo $filename | cut -d'/' -f1-3)
class=${filename//$path\//}
class=${class//\//.}
class=${class//.story/}
class=${class//.java/}
class=${class//\-/_}

class=${class//src.jbehave.stories./}

./gradlew clean
./gradlew jbehave --tests "$class"


url="file://$basepath/build/reports/tests/jbehave/classes/${pathArray[len-1]/-/_}.$class.html"

w3m -dump $url > /tmp/buildOut






