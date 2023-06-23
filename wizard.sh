#!/bin/sh
trap "exit" INT HUP TERM ERR

gum format --  "# --- Welcome to the uBlue image creation wizard! --- "

cd /host

gum format -- "To get started, please log in to Github. This is used to set up the repository, **nothing will be deleted or modified, only added!** You can read the source code of this script in [the repo](https://github.com/EinoHR/create-ublue-image/)."
echo
gh auth login -p https -w -s workflow
GIT_USER=$(gh api /user | jq '.login' -r)

echo
gum format -- "## Please input a name for the directory you want to clone your custom image repository to." "A directory with this name will be created inside your working directory."
echo
REPO_DIR=$(gum input --placeholder "ie. my-ublue")
gh repo clone ublue-os/startingpoint $REPO_DIR

cd $REPO_DIR
git remote rm upstream
git remote rename origin upstream

echo
gum format -- "## Please input a name for the public repository on Github for your custom image." "A repository and package with this name will be created using your github account."
echo
REPO_NAME=$(gum input --placeholder "ie. my-ublue, org-name/silverblue-for-cats")
gh repo create $REPO_NAME --source . --push --public
if [ $REPO_NAME == *"/"* ]; then
    REPO_FULL_NAME=$REPO_NAME
    gh repo set-default $REPO_FULL_NAME
else
    REPO_FULL_NAME=$GIT_USER/$REPO_NAME
    gh repo set-default $REPO_FULL_NAME
fi

echo "Setting up git for changes..."
git config user.name $GIT_USER
git config user.email $GIT_USER@users.noreply.github.com

echo "Enabling container signing..."
echo
gum format -- "**Please do not input a password when prompted,** instead just press enter. The container signing wont work in Github CI if you have an encrypted signing key."
echo
cosign generate-key-pair
gh secret set SIGNING_SECRET -R $REPO_FULL_NAME < cosign.key
git add cosign.pub && git commit -m "chore(automatic): add public key"

echo "Renaming your image from \"startingpoint\" to $REPO_NAME..."

# Set the image name in recipe.yml
yq -i ".name =  \"$REPO_NAME\"" recipe.yml
git add ./recipe.yml
git commit -m "chore(automatic): change image name"

# The repo full name has to be escaped for use with sed and lowercased for GHCR compatibility
ESCAPED_REPO_FULL_NAME=$(echo $REPO_FULL_NAME | sed "s;\/;\\\/;" | tr '[:upper:]' '[:lower:]')
sed -i "s/ublue-os\/startingpoint/$ESCAPED_REPO_FULL_NAME/g" ./README.md
git add README.md
git commit -m "chore(automatic): update all repo/image links"

sed -i "s/^# .*/# $REPO_NAME/" ./README.md
git add README.md
git commit -m "chore(automatic): update main title"

git push

gum format -- "# All done!" \
"[Your new Github repository](https://github.com/$REPO_FULL_NAME/). A build has been kicked off and an image will be available soon. After that, a new image will be built nightly." \
"If the build does not start automatically, you can go run it manually [here](https://github.com/$REPO_FULL_NAME/actions/workflows/build.yml)"