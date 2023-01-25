#!/bin/bash

export JENKINS_URL="http://int-ci-d02.sixt.de:8080"

username=$(pass show Sixt/jenkinsToken | tail -n1)
token=$(pass show Sixt/jenkinsToken | head -n1)
export JENKINS_AUTH="$username:$token"

export JENKINS_JAR="$HOME/.dotfiles/scripts/.local/bin/jenkins-cli.jar"

export JENKINS_EXEC="java -jar $JENKINS_JAR"
export JENKINS_CLI="$JENKINS_EXEC -auth @$JENKINS_AUTH -s $JENKINS_URL"

alias jenkins-cli="$JENKINS_CLI"

option=$(echo -e "show\nbuild" | choose )

job=$(cat "$HOME/.dotfiles/scripts/.local/bin/collection/date/empty" "$HOME/.dotfiles/scripts/.local/bin/collection/data/jeninsJobList" | choose)

echo $job
if [ "$job" != "" ]; then
    if [[ "$job" == *"BUILD"* ]]; then 
        jobname="$job/master"
        link="$JENKINS_URL/job/$job/job/master/"
    else 
        jobname="$job"
        link="$JENKINS_URL/job/$job/"
    fi

    if [ "$option" == "build" ]; then
echo        $JENKINS_EXEC -webSocket -auth $JENKINS_AUTH -s $JENKINS_URL build $jobname

    fi
echo $link
    qutebrowser "$link"
fi






