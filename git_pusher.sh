#!/bin/bash

cd /home/bigboy/Documents/Development/Marietta/placement/
dt=$(date '+%d/%m/%Y %H:%M:%S');
git_message="Backup $dt"
echo "$git_message"

git add *.Rmd
git commit -m "$git_message"
git push
