#!/bin/bash

if [ $# -ne 2 ]
then
    echo "Usage $0 USERNAME PASSWORD"
    exit 1
fi

fly -t poc login -c http://127.0.0.1:8080 -u $1 -p $2
