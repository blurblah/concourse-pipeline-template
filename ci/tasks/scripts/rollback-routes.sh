#!/bin/bash

set -xe

cf api $PWS_API --skip-ssl-validation
cf login -u $PWS_USER -p $PWS_PWD -o "$PWS_ORG" -s "$PWS_SPACE"

curr_color=`cf apps | grep "$PWS_APP_HOSTNAME.$PWS_APP_DOMAIN" | cut -d' ' -f1 | awk -F"-" '{print $NF}'`
if [ "$curr_color" == "blue" ]
then
    prev_color="green"
else
    prev_color="blue"
fi

echo "Mapping previous app route to point to $PWS_APP_HOSTNAME-$next_color instance"
is_exist_previous_app=`cf apps | grep "$PWS_APP_HOSTNAME\-$prev_color" | wc -l || true`
if [ $is_exist_previous_app -ne 0 ]
then
    echo "$PWS_APP_HOSTNAME-$prev_color exists!"
    cf map-route "$PWS_APP_HOSTNAME-$prev_color" $PWS_APP_DOMAIN --hostname $PWS_APP_HOSTNAME
fi
cf routes

echo "Removing current service app route that pointed to $PWS_APP_HOSTNAME-$curr_color instance"
is_exist_current_app=`cf apps | grep "$PWS_APP_HOSTNAME.$PWS_APP_DOMAIN" | grep "$PWS_APP_HOSTNAME\-$curr_color" | wc -l || true`
if [ $is_exist_current_app -ne 0 ]
then
    echo "$PWS_APP_HOSTNAME-$curr_color exists!"
    cf unmap-route "$PWS_APP_HOSTNAME-$curr_color" $PWS_APP_DOMAIN --hostname $PWS_APP_HOSTNAME
fi

echo "Routes updated"
cf routes
