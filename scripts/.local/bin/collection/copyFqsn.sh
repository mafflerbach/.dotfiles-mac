#!/bin/bash

FQSN=`ls -1tr /Users/maren/development/solutions.common.configuration.dev/src | choose ` 

echo "export FQSN=${FQSN//\-/_}" > /Users/maren/exportedVars 
echo ${FQSN//\-/_} | clipcopy
