#!/bin/bash

# check if something is playing, if it is, don't bother


if $(su -c "pactl list" -s /bin/sh thesaneone | grep RUNNING > /dev/null); then
	logger -t autosuspend "mUzAc pLaYin!"
	exit 1;
else
	echo "heyyoooo"

fi
