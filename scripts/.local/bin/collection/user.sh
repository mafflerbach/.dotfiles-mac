#!/bin/bash

# shopt -s nullglob globstar

typeit=0
if [[ $1 == "--type" ]]; then
	typeit=1
	shift
fi

prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

passwordFile=$(find $prefix -name "*.gpg" | sed -e "s/\.\///" -e "s#/Users/maren/.password-store/##" | choose)
path=${passwordFile/\.gpg/ }

[[ -n $passwordFile ]] || exit

if [[ $typeit -eq 0 ]]; then
echo $path
    pass show -c $path 
else
    uname=$(pass show $path | tail -n1 )

osascript /Users/maren/applescript/tuser.scpt "$uname" 
fi
