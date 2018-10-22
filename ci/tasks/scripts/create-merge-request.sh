#!/bin/bash

set -xe

cd pipeline-repo/bin
tar xvfz lab_*.tar.gz
chmod +x lab

mkdir -p ~/.config
lab_config=~/.config/lab.hcl
echo "\"core\" = {" > $lab_config
echo "  \"host\" = \"$GITLAB_HOST\"" >> $lab_config
echo "  \"token\" = \"$GITLAB_TOKEN\"" >> $lab_config
echo "  \"user\" = \"$GITLAB_USERNAME\"" >> $lab_config
echo "}" >> $lab_config
cat $lab_config

version=$(cat ../../release-candidate-dev/version.txt)
cd ../../source-repo
git branch
git remote -v
../pipeline-repo/bin/lab mr create origin $PROD_BRANCH -m "Promote and deploy release $version"
