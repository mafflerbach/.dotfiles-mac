#!/bin/bash

filename=$1
current=$(pwd)

class=${filename//\//.}
class=${class//.story/}

class=${class//src.jbehave.stories./}

input=$current/build/test-results/jbehave/TEST-$class.xml

xsltproc -o /tmp/testOutput.md ~/dotfiles/scripts/data/testOutputTransform.xsl $input
