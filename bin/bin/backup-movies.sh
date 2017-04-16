#!/bin/sh

if $(mountpoint -q /movies) && $(mountpoint -q /movies1) 
then
    echo "mounted - proceeding"
    flock -n /tmp/lock_movies_sync -c "/home/thesaneone/bin/mirror_one_way -l /movies/ /movies1"
else
    echo "not mounted - fuck off"
fi
