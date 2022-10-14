#!/bin/bash 

url=$1



data=$(youtube-dl -j $url | jq ".title, .id " | jq -s)

title=$(echo $data | jq '.[0]' | sed -e 's/"//g')
id=$(echo $data | jq '.[1]'| sed -e 's/"//g')




template='<iframe width="640" height="360" src="https://www.youtube.com/embed/'$id'" title="'$title'" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'
  echo $template
