#!/bin/bash

if [ -z "$(git diff origin README.md)" ]
then
	git add README.md
	git commit -m "rendered README.md" || exit 0
	git status
	git push origin $(git rev-parse --abbrev-ref HEAD)
fi
