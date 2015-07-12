#!/bin/bash

SRC="$HOME"
DEST="/media/data"
REMOTECOPY=
DRYRUN=

echo ---------------------- syncing dumps --------------------------------

copy_one_way $REMOTECOPY $DRYRUN "$SRC"/dumps "$DEST"

echo ---------------------- end syncing dumps ----------------------------

echo ---------------------- syncing videos --------------------------------

copy_one_way $REMOTECOPY $DRYRUN "$SRC"/videos "$DEST"

echo ---------------------- end syncing videos ----------------------------

echo ---------------------- syncing music --------------------------------

mirror_one_way $REMOTECOPY $DRYRUN "$SRC"/music "$DEST"

echo ---------------------- end syncing music ----------------------------

echo ---------------------- syncing photos --------------------------------

copy_one_way $REMOTECOPY $DRYRUN "$SRC"/photos "$DEST"

echo ---------------------- end syncing photos ----------------------------

echo ---------------------- syncing vboxes --------------------------------

copy_one_way $REMOTECOPY $DRYRUN "$SRC"/vbox "$DEST"

echo ---------------------- end syncing vboxes ----------------------------

echo ---------------------- syncing dropbox --------------------------------

mirror_one_way $REMOTECOPY $DRYRUN "$SRC"/Dropbox "$DEST"

echo ---------------------- end dropbox ----------------------------

if [ -f /media/truecrypt1 ]; then
    echo Sneaking little hobbitses..
    copy_one_way $REMOTECOPY $DRYRUN "$SRC"/.xmlback/po "/media/truecrypt1"
    echo done!
fi
