#!/bin/bash

set -xe

cf api $PWS_API --skip-ssl-validation
cf login -u $PWS_USER -p $PWS_PWD -o $PWS_ORG -s $PWS_SPACE

color=`cf apps | grep "$PWS_APP_HOSTNAME.$PWS_APP_DOMAIN" | cut -d' ' -f1 | awk -F"-" '{print $NF}'`
if [ "$color" == "blue" ]
then
    next_color="green"
else
    next_color="blue"
fi

cd color-info
echo $next_color > next_color.txt
cat next_color.txt
