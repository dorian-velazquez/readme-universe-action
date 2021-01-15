#!/bin/bash

BRANCH_NAME="readme"


echo "Branch: [$BRANCH_NAME]"

# checkout the branch, if specified
if [ "$BRANCH_NAME" != "main" ]; then
# try to check out the origin, if fails, then create the local branch
	git fetch && git checkout $BRANCH_NAME && git pull || git checkout -b $BRANCH_NAME
fi

git add README.md
git commit -m "rendered README.md" || exit 0
git status
git push origin develop
