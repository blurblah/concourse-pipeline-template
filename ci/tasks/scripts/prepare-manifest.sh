#!/bin/bash

set -xe

cd output
release_candidate=$(cat ../release-candidate-dev/release_candidate.txt)
cp -f ../release-candidate-dev/$release_candidate ./app.jar

app_name=$(cat ../source-repo/$PROJECT_ROOT/manifest.yml | grep "name:" | awk -F" " '{print $NF}')
sed "s/name:.*/name: $app_name-$PWS_SPACE/" ../source-repo/$PROJECT_ROOT/manifest.yml > manifest.yml
sed -i "s/path:.*/path: .\/app.jar/" manifest.yml
cat manifest.yml
