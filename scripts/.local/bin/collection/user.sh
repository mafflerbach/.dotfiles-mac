#!/bin/bash

shopt -s nullglob globstar

typeit=0
if [[ $1 == "--type" ]]; then
	typeit=1
	shift
fi

prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

password=$(printf '%s\n' "${password_files[@]}" | rofi -dmenu "$@" -theme $HOME/.config/rofi/rofi.rasi)
echo $password
[[ -n $password ]] || exit

if [[ $typeit -eq 0 ]]; then
    pass show -c "$password" | tail -n1  2>/dev/null

else
    uname=$(pass show $password | tail -n1 )
    xdotool type "$uname"
fi
