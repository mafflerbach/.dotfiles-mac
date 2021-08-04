#!/bin/bash

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk;

IFS='/' read -r -a pathArray <<< "$1"

len=${#pathArray[@]};
file=$( echo ${pathArray[len-1]} | cut -d'.' -f1 )
filename=${pathArray[len-3]}.${pathArray[len-2]}.$file
echo "RUN mvn test --offline -Dtest=$filename"
mvn test -Dtest=$filename > /tmp/build

