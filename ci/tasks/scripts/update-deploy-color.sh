#!/bin/bash

set -xe

cd pipeline-repo/bin
mv fly_linux_amd64 fly
chmod +x fly
./fly -t local login -c ${CONCOURSE_URL} -u ${CONCOURSE_USERNAME} -p ${CONCOURSE_PASSWORD}
./fly -t local sync
./fly -t local get-pipeline -p ${CONCOURSE_PIPELINE} > original-pipeline.yml

# TODO: Decide color
COLOR=$(cat original_pipeline.yml | grep '\- name: Deploy-*' | cut -d':' -f2 | cut -d'-' -f2)
if [ "$COLOR" == "blue" ]
then
    NEXT_COLOR="green"
else
    NEXT_COLOR="blue"
fi
# End of the temporary color decision routine

sed "s/Deploy-.*/Deploy-${NEXT_COLOR}/" original-pipeline.yml > updated-pipeline.yml
cat updated-pipeline.yml

./fly -t local set-pipeline -p ${CONCOURSE_PIPELINE} -c updated-pipeline.yml -n
