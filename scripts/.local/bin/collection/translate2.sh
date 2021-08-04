#!/usr/bin/env bash

input=$(rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi)


translation=$(trans $input)


echo $translation | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi
