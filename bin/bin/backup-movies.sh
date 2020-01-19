#!/bin/sh

if $(mountpoint -q /movies) && $(mountpoint -q /movies1) 
then
    logger -t "BACKUPMOVIES"  -p WARN "not mounted - not backingup"
    flock -n /tmp/lock_movies_sync -c "/home/thesaneone/bin/mirror_one_way -l /movies/ /movies1"
else
    logger -t "BACKUPMOVIES"  -p WARN "not mounted - not backingup"
fi
