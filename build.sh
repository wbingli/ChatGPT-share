#!/bin/sh
cd src

VERSION=$(cat manifest.json | grep '"version":' | cut -d '"' -f 4)
echo "Building version $VERSION"

# create dist folder
mkdir -p ../dist/v${VERSION}

# build chrome
zip -r ../dist/v${VERSION}/chrome-chatgpt-share-v${VERSION}.zip .

# replace manifest version from 3 to 2
if [ "$(uname)" == "Darwin" ]; then
  sed -i "" 's/"manifest_version": 3/"manifest_version": 2/g' manifest.json
else
  sed -i 's/"manifest_version": 3/"manifest_version": 2/g' manifest.json
fi

# build firefox
zip -r ../dist/v${VERSION}/firefox-chatgpt-share-v${VERSION}.zip .

# restore manifest version from 2 to 3
if [ "$(uname)" == "Darwin" ]; then
  sed -i "" 's/"manifest_version": 2/"manifest_version": 3/g' manifest.json
else
  sed -i 's/"manifest_version": 2/"manifest_version": 3/g' manifest.json
fi

cd ..
