#!/bin/bash

set -xe

mkdir -p /root/.m2/repository
cp -r /app/m2/* /root/.m2/repository/

cd source-repo
./mvnw clean package
#mvn clean package
COMMIT_HASH=$(git rev-parse HEAD | cut -c 1-8)
echo $COMMIT_HASH

cd ../build-out-repo
shopt -s dotglob
# to move .git metadata
mv -f ../out-repo/* ./

mv -f ../source-repo/target ./
ls -al target

FILENAME=`basename $(ls target/*.jar)`
FILENAME_WO_EXT=${FILENAME%.*}
mkdir $FILENAME_WO_EXT
cp target/*.jar ${FILENAME_WO_EXT}/${FILENAME_WO_EXT}-${COMMIT_HASH}.jar
ls -al $FILENAME_WO_EXT

git config --global user.email "${GIT_EMAIL}"
git config --global user.name "${GIT_USERNAME}"
git status
git add .
git commit -m "[CI] Pushing jar ${FILENAME_WO_EXT}-${COMMIT_HASH}.jar"
