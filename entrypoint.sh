#!/bin/bash

git add README.md
git commit -m "rendered README.md" || exit 1
git status
git push origin automation
