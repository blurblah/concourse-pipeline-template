#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 PIPELINE_NAME"
    echo "You should have credentials.yml file in this directory."
    exit 1
fi

fly -t poc set-pipeline -p $1 -c ci/pipeline.yml -l credentials.yml
