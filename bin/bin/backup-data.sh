#!/bin/bash

if $(mountpoint -q /data) && $(mountpoint -q /data1) 
then
    logger -t "BACKUPDATA"  -p WARN "mounted - proceeding"
    flock -n /tmp/lock_data_sync -c "${HOME}/bin/mirror_one_way -l /data/ /data1"
else
    logger -t "BACKUPDATA"  -p WARN "not mounted - not backingup"
fi
