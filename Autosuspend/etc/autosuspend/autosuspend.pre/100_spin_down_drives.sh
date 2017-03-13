#!/bin/bash

# this will be (only?) required to spin down external drives

FIND_DEVS='sd[c-z]'

sync
for f in $(find /dev -name $FIND_DEVS)
do
	hdparm -y $f &
done
wait
exit 0
