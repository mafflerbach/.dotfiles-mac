#!/bin/bash

class="$1"
path=$(pwd)

url="file://$path/build/reports/tests/jbehave/classes/$class.html"

w3m -dump $url > /tmp/buildOut


