#!/bin/bash

if [ -z "$(git diff origin/main --  README.md)" ]
then
	git add README.md
	git commit -m "rendered README.md" || exit 0
	git status
fi
