#!/bin/sh

if $(mountpoint -q /data) && $(mountpoint -q /tv) 
then
    logger -t "BACKUPDATA"  -p WARN "mounted - proceeding"
    flock -n /tmp/lock_data_sync -c "/home/thesaneone/bin/mirror_one_way -l /data/ /tv/data1"
else
    logger -t "BACKUPDATA"  -p WARN "not mounted - not backingup"
fi
