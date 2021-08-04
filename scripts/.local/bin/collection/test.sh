#!/bin/bash

export JENKINS_URL="http://url.to.jenins"
export JENKINS_AUTH="$HOME/dotfiles/.jenkins.cli.secret"
export JENKINS_JAR="$HOME/.local/bin/jenkins-cli.jar"

export JENKINS_CLI="java -jar $JENKINS_JAR -auth @$JENKINS_AUTH -s $JENKINS_URL"

# check date of file if older 7 days
if [ "$(find '/tmp/jenkinsJobList' -ctime +7)" ]; then
    echo "fetch joblist"
    $JENKINS_CLI list-jobs > /tmp/jenkinsJobList
fi

# job selection via fuzzy search 
job=$(cat /tmp/empty /tmp/jenkinsJobList | rofi -dmenu -theme $HOME/.config/rofi/rofi.rasi)

# triggering the job
$JENKINS_CLI build $job

# opens the pipeline in browser
qutebrowser "$JENKINS_URL/job/$job"
