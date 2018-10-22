#!/bin/bash

set -xe

cd pipeline-repo/bin
mv fly_linux_amd64 fly
chmod +x fly
./fly -t local login -c ${CONCOURSE_URL} -u ${CONCOURSE_USERNAME} -p ${CONCOURSE_PASSWORD}
./fly -t local sync
./fly -t local get-pipeline -p ${CONCOURSE_PIPELINE} > original-pipeline.yml

version=$(cat ../../build-out-repo/version.txt)
sed "s/Deploy-to-dev-.*/Deploy-to-dev-${version}/" original-pipeline.yml > updated-pipeline.yml
cat updated-pipeline.yml

./fly -t local set-pipeline -p ${CONCOURSE_PIPELINE} -c updated-pipeline.yml -n
