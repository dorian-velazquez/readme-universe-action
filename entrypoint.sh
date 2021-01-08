#!/bin/bash


# initalize git
echo "Intiializing git"
git config --system core.longpaths true
git config --global core.longpaths true
git config --global user.email "action-bot@github.com" && git config --global user.name "Github Action"
echo "Git initialized"

# create repos dir
mkdir repos
cd repos

# iterate directories to clone
for repository in "${REPOSITORIES[@]}";
do
    echo "::group::$repository"

    # determine repo name
    REPO_INFO=($(echo $repository | tr "@" "\n"))
    REPO_NAME=${REPO_INFO[0]}
    echo "Repository name: [$REPO_NAME]"

    # determine branch name
    BRANCH_NAME="automation"
    if [ ${REPO_INFO[1]+yes} ]; then
        BRANCH_NAME="${REPO_INFO[1]}"
    fi
    echo "Branch: [$BRANCH_NAME]"

    # clone the repo
    REPO_URL="https://x-access-token:${GITHUB_TOKEN}@github.com/${REPO_NAME}.git"
    GIT_PATH="${TEMP_PATH}${REPO_NAME}"
    git clone --quiet --no-hardlinks --no-tags $REPO_URL $REPO_NAME

done

echo "$(ls)" 
