#!/bin/bash

set -xe

cd pipeline-repo/bin
chmod +x fly
./fly -t local login -c ${CONCOURSE_URL} -n ${CONCOURSE_TEAM} -u ${CONCOURSE_USERNAME} -p ${CONCOURSE_PASSWORD}
./fly -t local sync
./fly -t local get-pipeline -p ${CONCOURSE_PIPELINE} > original_pipeline.yml

# TODO: Decide color


sed "s/Deploy-*/Deploy-${COLOR}/" original_pipeline.yml > updated_pipeline.yml
./fly -t local set-pipeline -p ${CONCOURSE_PIPELINE} -c ./updated_pipeline.yml -n
