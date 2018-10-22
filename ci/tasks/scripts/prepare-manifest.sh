#!/bin/bash

set -xe

cd output
release_candidate=$(cat ../release-candidate-dev/release_candidate.txt)
cp -f ../release-candidate-dev/$release_candidate ./app.jar

sed "s/path:.*/path: .\/app.jar/" ../source-repo/manifest.yml > manifest.yml
cat manifest.yml
