#!/bin/bash

set -xe

cf api $PWS_API --skip-ssl-validation
cf login -u $PWS_USER -p $PWS_PWD -o "$PWS_ORG" -s "$PWS_SPACE"

curr_color=`cf apps | grep "$PWS_APP_HOSTNAME.$PWS_APP_DOMAIN" | cut -d' ' -f1 | awk -F"-" '{print $NF}'`
if [ "$curr_color" == "blue" ]
then
    next_color="green"
else
    next_color="blue"
fi

echo "Mapping main app route to point to $PWS_APP_HOSTNAME-$next_color instance"
cf map-route "$PWS_APP_HOSTNAME-$next_color" $PWS_APP_DOMAIN --hostname $PWS_APP_HOSTNAME

echo "Removing current service app route that pointed to $PWS_APP_HOSTNAME-$curr_color instance"
is_exist_current_app=`cf apps | grep "$PWS_APP_HOSTNAME.$PWS_APP_DOMAIN" | grep "$PWS_APP_HOSTNAME\-$curr_color" | wc -l || true`
if [ -n "$curr_color" ] && [ $is_exist_current_app -ne 0 ]
then
    echo "$PWS_APP_HOSTNAME-$curr_color exists!"
    cf unmap-route "$PWS_APP_HOSTNAME-$curr_color" $PWS_APP_DOMAIN --hostname $PWS_APP_HOSTNAME
fi

echo "Routes updated"
cf routes
