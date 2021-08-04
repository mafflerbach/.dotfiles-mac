#!/bin/bash

# generate dependency list if not exists
if [ ! -f .dependencies ]; then
    echo "Generate dependency list"
    mvn dependency:list -DoutputFile=./.dependencies
fi

# check the last modified, if pom is younger the dependency list will be updated
if [ .dependencies -ot pom.xml  ]
then
    mvn dependency:list -DoutputFile=./.dependencies
fi
# open selection list for the dependencies
dependencies=$(cat ./.dependencies|fzf)

packagePath=$(echo $dependencies | cut -d':' -f1 | sed -e 's/\./\//g')
packageName=$(echo $dependencies | cut -d':' -f2)
version=$(echo $dependencies | cut -d':' -f4)

path=$packagePath/$packageName/$version
jar=$packageName-$version.jar

# open selection list for the containing class of the package
classFile=$(jar tf /home/maren/.m2/repository/$path/$jar | grep class | fzf )

# shows the public methods of the classes.
output=$(javap  jar:file:///home/maren/.m2/repository/$path/$jar!/$classFile)
# like cat but on steroids. 
bat --line-range 2:9999 -l Java <<<  $output
