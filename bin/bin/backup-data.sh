#!/bin/sh

if $(mountpoint -q /data) && $(mountpoint -q /tv) 
then
    echo "mounted - proceeding"
    flock -n /tmp/lock_data_sync -c "/home/thesaneone/bin/mirror_one_way -l /data/ /tv/data1"
else
    echo "not mounted - fuck off"
fi
