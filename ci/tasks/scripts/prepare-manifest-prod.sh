#!/bin/bash

set -xe

cd output
release_candidate=$(cat ../release-candidate-prod/release_candidate.txt)
cp -f ../release-candidate-prod/$release_candidate ./app.jar

color=$(cat ../color-info/next_color.txt)
sed "s/name:.*/name: $PWS_APP_HOSTNAME-$color/" ../deployment-approval/manifest.yml > manifest.yml
sed -i "s/path:.*/path: .\/app.jar/" manifest.yml
cat manifest.yml
