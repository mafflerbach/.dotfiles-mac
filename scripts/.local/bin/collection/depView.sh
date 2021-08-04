#!/bin/bash

input="data/testList2"
while IFS= read -r line
do

    echo "$line"
done < "$input"

