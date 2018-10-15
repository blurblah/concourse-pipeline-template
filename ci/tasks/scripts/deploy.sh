#!/bin/bash

cd out-repo

# TODO: Deploy

echo "http://test-app.apps.dkpcf.posco.co.kr" > deployed_url.txt
git add .
git commit -m "[CI] Push deployed url"
