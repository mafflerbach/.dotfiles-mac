#!/bin/bash

filename=$1

if [[ $filename == *"Test"* ]]; then
    newFileName=${filename/Test/}
    newFileName=${newFileName/test/main}
else 
    newFileName=${filename/\.java/Test.java}
    newFileName=${newFileName/main/test}
fi
echo $newFileName
