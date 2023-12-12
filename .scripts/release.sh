#!/usr/bin/env bash

cd ..

echo
echo "🚀 Lets make a new release!"
echo "==========================="
echo
echo "Preparation steps:"
echo "   🚨 Run this from inside the folder .scripts"
echo "   🧑‍💻 krankerl is installed"
echo "   🔐 Sign keys are under '~/.nextcloud'"
echo
echo "   ✅ All code changes are committed and merged"
echo "   🍀 CI is green"
echo
echo "   💯 Version number bumped"
echo "   💬 File 'releaseNotes.md' is up to date"
echo "   📺 Update screenshots if needed"
echo
read -r -p "Are all the prepare steps done? [y/N] " CONFIRMATION

if [[ "$CONFIRMATION" == "n" || "$CONFIRMATION" == "N" || -z "$CONFIRMATION" ]]; then
  echo
  echo "Aboard, please prepare carefully."
  exit 1
fi

echo
read -r -p "Give me the release name (eg 'v0.6.0' or 'v0.6.0-beta.1'): " NAME

if [[ -z "$NAME" ]]; then
    echo
    echo "🙄 Aboard, you have to give me a name."
    exit 1
fi

echo
echo "# Build package"
echo "krankerl package"
echo "========================="
krankerl package

echo
echo "# create tag for this release"
echo "git tag -a $NAME -m '$NAME'"
echo "========================="
git tag -a "$NAME" -m "$NAME"

echo
echo "# push tag to repo origin"
echo "git push -u origin $NAME"
echo "========================="
git push -u origin "$NAME"

# echo
# echo "# push tag to repo releases"
# echo "git push -u releases $NAME"
# echo "========================="
# git push -u releases "$NAME"

echo
echo "# publish at github repo origin"
echo "gh release --repo nextcloud/health create '$NAME' ./build/artifacts/health.tar.gz --notes-file releaseNotes.md -t 'Nextcloud health $NAME'"
echo "========================="
gh release --repo nextcloud/health create "$NAME" ./build/artifacts/health.tar.gz --notes-file releaseNotes.md -t "Nextcloud health $NAME"

# echo
# echo "# publish at github repo releases"
# echo "gh release --repo nextcloud-releases/health create '$NAME' ./build/artifacts/health.tar.gz --notes-file releaseNotes.md -t 'Nextcloud health $NAME'"
# echo "========================="
# gh release --repo nextcloud-releases/health create "$NAME" ./build/artifacts/health.tar.gz --notes-file releaseNotes.md -t "Nextcloud health $NAME"


echo
echo "# publish at appstore"
echo "krankerl publish https://github.com/nextcloud/health/releases/download/$NAME/health.tar.gz"
echo "========================="
bash -c "krankerl publish https://github.com/nextcloud/health/releases/download/$NAME/health.tar.gz"

echo
echo "Maybe you should create a stable-branch..."

echo
echo "🍻 Cheers"
echo
exit 1
