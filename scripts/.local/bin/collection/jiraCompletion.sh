#!/bin/bash

sprint=$(jira sprint)
runBoard=$(jira cleanrun)
platform=$(jira cleanplatform)

echo -e "$sprint \n\n$runBoard \n\n$platform"
