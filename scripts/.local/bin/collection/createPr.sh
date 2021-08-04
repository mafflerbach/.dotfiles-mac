#!/bin/bash
currentBranch=$(git branch --show-current)
gh pr create --title "$currentBranch" --body "" 


