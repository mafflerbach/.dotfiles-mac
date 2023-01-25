#!/bin/bash

env=$(echo -e "DEV\nSTAGE\nPROD" | choose )

FQSN=`exa -1 --no-icons ~/development/solutions.common.configuration.dev/src | choose ` 
qutebrowser "https://int-ci-d01.sixt.de/jenkins/megatron/job/Solution/job/Deployment/job/$env/job/$FQSN/build"


