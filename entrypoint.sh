#!/bin/bash

git add README.md
git commit -m "rendered README.md" || exit 0
git status
git push origin automation
