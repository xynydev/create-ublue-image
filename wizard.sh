#!/bin/sh
echo "--- Welcome to the uBlue image creation wizard! --- "

cd /host

echo "To get started, please log in to Github. This is used to set up the repository, nothing will be deleted or modified, only added!"
gh auth login

REPO_DIR=$(gum input --placeholder "Directory name for your custom image repository.")

gh repo clone ublue-os/startingpoint $REPO_DIR