#!/bin/bash
parentTicket="$1"

jira subtask $parentTicket --override reporter="m9338" --override summary="Deploy and testing - Dev" --noedit
jira subtask $parentTicket --override reporter="m9338" --override summary="Deploy and testing - Stage" --noedit
jira subtask $parentTicket --override reporter="m9338" --override summary="Implementation" --noedit
jira subtask $parentTicket --override reporter="m9338" --override summary="Peer review" --noedit
jira subtask $parentTicket --override reporter="m9338" --override summary="Documentation" --noedit
# jira subtask $parentTicket --override summary="Migration" --noedit



