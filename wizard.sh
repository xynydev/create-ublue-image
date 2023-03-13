#!/bin/sh
echo "--- Welcome to the uBlue image creation wizard! --- "

cd /host

echo "To get started, please log in to Github. This is used to set up the repository, nothing will be deleted or modified, only added!"
gh auth login -p https -w

echo ""
REPO_DIR=$(gum input --placeholder "Directory name for your custom image repository.")
gh repo clone ublue-os/startingpoint $REPO_DIR

cd $REPO_DIR
git remote rm upstream
git remote rename origin upstream

echo ""
REPO_NAME=$(gum input --placeholder "Public repository name on Github for your custom image repository.")
gh repo create $REPO_NAME --source . --push --public 