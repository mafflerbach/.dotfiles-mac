#!/bin/bash

input="/home/maren/.cache/wal/colors.yml"

yq r ~/.cache/wal/colors.yml special.background
yq r ~/.cache/wal/colors.yml special.foreground


background=$(yq r ~/.cache/wal/colors.yml special.background )
foreground=$(yq r ~/.cache/wal/colors.yml special.foreground )

color0=$(yq r ~/.cache/wal/colors.yml colors.color0 )
color1=$(yq r ~/.cache/wal/colors.yml colors.color1 )
color2=$(yq r ~/.cache/wal/colors.yml colors.color2 )
color3=$(yq r ~/.cache/wal/colors.yml colors.color3 )
color4=$(yq r ~/.cache/wal/colors.yml colors.color4 )
color5=$(yq r ~/.cache/wal/colors.yml colors.color5 )
color6=$(yq r ~/.cache/wal/colors.yml colors.color6 )
color7=$(yq r ~/.cache/wal/colors.yml colors.color7 )
color8=$(yq r ~/.cache/wal/colors.yml colors.color8 )
color9=$(yq r ~/.cache/wal/colors.yml colors.color9 )
color10=$(yq r ~/.cache/wal/colors.yml colors.color10 )
color11=$(yq r ~/.cache/wal/colors.yml colors.color11 )
color12=$(yq r ~/.cache/wal/colors.yml colors.color12 )
color13=$(yq r ~/.cache/wal/colors.yml colors.color13 )
color14=$(yq r ~/.cache/wal/colors.yml colors.color14 )
color15=$(yq r ~/.cache/wal/colors.yml colors.color15 )

sed -e "s/BGCOLOR/$background/g" \
    -e "s/FGCOLOR/$foreground/g" \
    -e "s/COLOR1/$color1/g" \
    -e "s/COLOR2/$color2/g" \
    -e "s/COLOR3/$color3/g" \
    -e "s/COLOR4/$color4/g" \
    -e "s/COLOR5/$color5/g" \
    -e "s/COLOR6/$color6/g" \
    -e "s/COLOR7/$color7/g" \
    -e "s/COLOR8/$color8/g" \
    -e "s/COLOR9/$color9/g" \
    -e "s/COLOR10/$color10/g" \
    -e "s/COLOR11/$color11/g" \
    -e "s/COLOR12/$color12/g" \
    -e "s/COLOR13/$color13/g" \
    -e "s/COLOR14/$color14/g" \
    -e "s/COLOR15/$color15/g" \
    /home/maren/dotfiles/xmobar/xmobarrc1-template > /home/maren/dotfiles/xmobar/xmobarrc1


sed -e "s/BGCOLOR/$background/g" \
    -e "s/FGCOLOR/$foreground/g" \
    -e "s/COLOR1/$color1/g" \
    -e "s/COLOR2/$color2/g" \
    -e "s/COLOR3/$color3/g" \
    -e "s/COLOR4/$color4/g" \
    -e "s/COLOR5/$color5/g" \
    -e "s/COLOR6/$color6/g" \
    -e "s/COLOR7/$color7/g" \
    -e "s/COLOR8/$color8/g" \
    -e "s/COLOR9/$color9/g" \
    -e "s/COLOR10/$color10/g" \
    -e "s/COLOR11/$color11/g" \
    -e "s/COLOR12/$color12/g" \
    -e "s/COLOR13/$color13/g" \
    -e "s/COLOR14/$color14/g" \
    -e "s/COLOR15/$color15/g" \
    /home/maren/dotfiles/xmobar/xmobarrc0-template > /home/maren/dotfiles/xmobar/xmobarrc0

sed -e "s/BGCOLOR/$background/g" \
    -e "s/FGCOLOR/$foreground/g" \
    -e "s/COLOR1/$color1/g" \
    -e "s/COLOR2/$color2/g" \
    -e "s/COLOR3/$color3/g" \
    -e "s/COLOR4/$color4/g" \
    -e "s/COLOR5/$color5/g" \
    -e "s/COLOR6/$color6/g" \
    -e "s/COLOR7/$color7/g" \
    -e "s/COLOR8/$color8/g" \
    -e "s/COLOR9/$color9/g" \
    -e "s/COLOR10/$color10/g" \
    -e "s/COLOR11/$color11/g" \
    -e "s/COLOR12/$color12/g" \
    -e "s/COLOR13/$color13/g" \
    -e "s/COLOR14/$color14/g" \
    -e "s/COLOR15/$color15/g" \
    /home/maren/dotfiles/xmonad/xmonad-template.hs > /home/maren/dotfiles/xmonad/xmonad.hs

killall xmobar
xmonad --recompile; xmonad --restart

