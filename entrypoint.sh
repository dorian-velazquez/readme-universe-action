#!/bin/bash

echo $(git status)
echo $(git rev-parse --abbrev-ref HEAD)
echo $(git remote -v)
git add README.md
git diff-index --quiet HEAD || git commit -m "rendered README.md" 
git status
git push origin $BRANCH_NAME
