#!/bin/bash

if [ $# -ne 2 ]
then
    echo "Usage: $0 [PIPELINE_NAME] [CREDENTIAL_FILE]"
    echo "You should have credentials.yml file in this directory."
    exit 1
fi

fly -t poc set-pipeline -p $1 -c ci/pipeline.yml -l $2
