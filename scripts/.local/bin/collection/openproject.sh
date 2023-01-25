#!/bin/zsh

FQSN=$1

if [ -d ~/development/$FQSN ]; then
    cd ~/development/$FQSN
    nvim
else 
    cd ~/development
   checkoutName="$FQSN"
    gh repo clone "Sixt-Int/$checkoutName"
    if [ -d ~/development/$checkoutName ]; then
        cd ~/development/$checkoutName
        nvim
    fi
fi

zsh

