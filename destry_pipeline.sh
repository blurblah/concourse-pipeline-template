#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 PIPELINE_NAME"
    exit 1
fi

fly -t poc destroy-pipeline -p $1
