#!/bin/bash

latestSession=$(tmux ls -F \#S | tail -n1)
kitty tmux attach-session -t $latestSession
