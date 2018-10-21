#!/bin/bash

set -xe

cd output
release_candidate=$(cat ../out-repo/release_candidate.txt)
cp -f ../out-repo/$release_candidate ./app.jar

color=$(cat ../color-info/next_color.txt)
sed "s/APPNAME/$PWS_APP_HOSTNAME\-$color/" ../pipeline-repo/manifests/manifest.yml > manifest.yml
cat manifest.yml
