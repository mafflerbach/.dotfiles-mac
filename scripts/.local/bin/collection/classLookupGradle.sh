#!/bin/bash

./gradlew dependencies 2>&1 > ./.dependencies


dependencies=$(cat ./.dependencies|fzf)

cleanLine=$(echo $dependencies |sed -e 's/.*-\s//g' -e's/ (c)//g' -e's/ (\*)//g')
packagePath=$(echo $cleanLine | cut -d':' -f1 | sed -e 's/\./\//g')
packageName=$(echo $cleanLine | cut -d':' -f2 )
version=$(echo $cleanLine | cut -d':' -f3)

path=$packagePath/$packageName/$version 
jar=$packageName-$version.jar
echo $path 
echo $jar

echo /home/maren/.m2/repository/$path/$jar 
#classFile=$(jar tf /home/maren/.m2/repository/$path/$jar | grep class | fzf )


#output=$(javap  jar:file:///home/maren/.m2/repository/$path/$jar!/$classFile)
# like cat but on steroids. 
#bat --line-range 2:9999 -l Java <<<  $output


