#!/bin/bash

export JENKINS_URL="http://int-ci-d02.sixt.de:8080"
export JENKINS_URL="https://int-ci-d01.sixt.de/jenkins/megatron"

export JENKINS_AUTH="$HOME/dotfiles/.jenkins.cli.secret"
export JENKINS_AUTH="$HOME/dotfiles/.jenkins.cli.secret2"

export JENKINS_JAR="$HOME/.local/bin/jenkins-cli.jar"

export JENKINS_CLI="java -jar $JENKINS_JAR -auth @$JENKINS_AUTH -s $JENKINS_URL -webSocket" 

# check date of file if older 7 days
if [ "$(find '/tmp/jenkinsJobList' -ctime +7)" ]; then
    echo "fetch joblist"
    $JENKINS_CLI list-jobs > /tmp/jenkinsJobList
fi

# job selection via fuzzy search 
job=$(cat /tmp/empty /tmp/jenkinsJobList | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi)

if [ "$job" != "" ]; then
    if [[ "$job" == *"BUILD"* ]]; then 
        $JENKINS_EXEC -auth @$JENKINS_AUTH -s $JENKINS_URL build $job/master
        qutebrowser "http://int-ci-d02.sixt.de:8080/job/$job/job/master/"
    else 
        echo $job
        $JENKINS_EXEC -auth @$JENKINS_AUTH -s $JENKINS_URL build $job
        qutebrowser "http://int-ci-d02.sixt.de:8080/job/$job/"
    fi
fi




