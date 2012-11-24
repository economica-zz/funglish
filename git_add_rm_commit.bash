#!/bin/bash
git add .
git status | grep deleted: | awk '{print $3}'  | xargs git rm
git commit -m "m"
