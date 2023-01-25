#!/bin/zsh

FQSN=`ls -1tr /Users/maren/development | choose ` 


echo "export FQSN=${FQSN//\-/_}" > /home/maren/exportedVars 
echo ${FQSN//\-/_} | xsel --clipboard --input

cd ~/development/$FQSN

zsh

