#!/usr/bin/bash


select=$(ls -1 /home/maren/.screenlayout | choose )


bash /home/maren/.screenlayout/$select
