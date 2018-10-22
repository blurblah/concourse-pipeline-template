#!/bin/bash

set -xe

mkdir -p /root/.m2/repository
cp -r /app/m2/* /root/.m2/repository/

cd deployment-approval
./mvnw clean package
#mvn clean package
commit_hash=$(git rev-parse HEAD | cut -c 1-8)
echo $commit_hash

cd ../build-out-repo
shopt -s dotglob
# to move .git metadata
mv -f ../release-candidate-prod/* ./

mv -f ../deployment-approval/target ./
ls -al target

filename=`basename $(ls target/*.jar)`
filename_wo_ext=${filename%.*}
mkdir -p $filename_wo_ext
release_candidate=${filename_wo_ext}/${filename_wo_ext}-${commit_hash}.jar
echo $release_candidate > release_candidate.txt

cp -f target/*.jar ${filename_wo_ext}/${filename_wo_ext}-${commit_hash}.jar
rm -rf target
ls -al $filename_wo_ext

git config --global user.email "${GIT_EMAIL}"
git config --global user.name "${GIT_USERNAME}"
git status
git add .
git commit -m "[CI] Push jar ${filename_wo_ext}-${commit_hash}.jar"
