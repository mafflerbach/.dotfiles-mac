#!/bin/bash

file="$1"
if [ "$2" == "" ]; then
    mode="dark"
else 
    mode="light"
fi

echo $mode


area=$(magick $file -format "%[fx:w*h]" info:)
# data=$(magick cyberpunk.jpg -kmeans 8 -format "%c" histogram:info:  | sed 's/://g' | awk -v area=$area '{print 100*$1/area, "%,", $3}' | sed 's/ *//g' | sort -nr -k1,1 -t ",")
data=$(magick $file  -kmeans 8 -format "%c" histogram:info:  | sed 's/://g' | awk -v area=$area '{print 100*$1/area, "%,", $3}' | sed 's/ *//g' | sort -nr -k1,1 -t ",")

data2=$(magick $file   -negate -kmeans 2 -format "%c" histogram:info:  | sed 's/://g' | awk -v area=$area '{print 100*$1/area, "%,", $3}' | sed 's/ *//g' | sort -nr -k1,1 -t ",")


fileItemString=$(echo "$data" | cut -d "," -f2 |tr "\n" " ")
arr=($fileItemString)

fileItemString2=$(echo "$data2" | cut -d "," -f2 |tr "\n" " ")
arr2=($fileItemString2)

test=${arr[0]}

if [ ${#test} -eq 9 ]; then 

    tmpArr=()

    total=${#arr[*]}
    for (( i=0; i<=$(( $total -1 )); i++ ))
    do 
        arr[$i]=${arr[$i]:0:7}
    done

    total=${#arr2[*]}
    for (( i=0; i<=$(( $total -1 )); i++ ))
    do 
        arr2[$i]=${arr2[$i]:0:7}
    done


    
fi

    if [ "$mode" == "light" ]; then
        fg=${arr2[0]}
        bg=${arr[0]}

        arr[0]=$fg
        arr2[0]=$bg

        echo 

    fi
echo "
{
    \"wallpaper\": \"$file\",
    \"alpha\": \"100\",
    \"special\": {
    \"background\": \"${arr[0]}\",
    \"foreground\": \"${arr2[0]}\",
    \"cursor\":     \"${arr2[0]}\"
},
\"colors\": {
\"color0\": \"${arr[0]}\",
\"color1\": \"${arr[1]}\",
\"color2\": \"${arr[2]}\",
\"color3\": \"${arr[3]}\",
\"color4\": \"${arr[4]}\",
\"color5\": \"${arr[5]}\",
\"color6\": \"${arr[6]}\",
\"color7\": \"${arr[7]}\",

\"color8\":  \"${arr[0]}\",
\"color9\":  \"${arr[1]}\",
\"color10\": \"${arr[2]}\",
\"color11\": \"${arr[3]}\",
\"color12\": \"${arr[4]}\",
\"color13\": \"${arr[5]}\",
\"color14\": \"${arr[6]}\",
\"color15\": \"${arr[7]}\"
}
}

" > ~/.dotfiles/scripts/.local/bin/collection/data/colorscheme.json



magick -size 1x1 xc: swatches.png
for item in $data; do
    color=`echo $item | cut -d, -f2`
    magick swatches.png \( -size 100x100 xc:"$color" \) +append swatches.png
done
magick swatches.png -gravity west -chop 1x /home/maren/.dotfiles/wallpaper/swatches.png
