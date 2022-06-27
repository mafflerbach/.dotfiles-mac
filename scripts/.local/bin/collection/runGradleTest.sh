#!/bin/bash

filename=$1


basepath=$(pwd)
path=$(echo $filename | cut -d'/' -f1-3)
echo $path
class=${filename//$path\//}
class=${class//\//.}
class=${class//.story/}
class=${class//.java/}
class=${class//\-/_}

class=${class//src.jbehave.stories./}
echo "./gradlew jbehave --tests $class 2>&1 | tee /tmp/gradlebuild" > /tmp/foo 
gradle jbehave --offline --tests "$class" 2>&1 |tee /tmp/gradlebuild


url="file://$basepath/build/reports/tests/jbehave/classes/$class.html"

w3m -dump $url > /tmp/buildOut


