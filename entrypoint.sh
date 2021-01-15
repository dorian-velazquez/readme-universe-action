#!/bin/bash

echo $(git status)
echo $(git rev-parse --abbrev-ref HEAD)
echo $(git remote -v)
if [ -z "$(git diff origin/main --  README.md)" ]
then
	git add README.md
	git commit -m "rendered README.md" 
	git status
	git push origin $BRANCH_NAME
fi
