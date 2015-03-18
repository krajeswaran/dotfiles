#!/bin/bash

ROOT_UID="0"

#Check if run as root
if [ "$UID" -ne "$ROOT_UID" ] ; then
	echo "You must be root to do that!"
	exit 1
fi

cd /usr/share/polkit-1/actions
ls -x | while read file; do perl -i -p -e 's/auth_admin_keep/yes/g' $file; done
ls -x | while read file; do perl -p -i -e 's:<allow_active>auth_admin</allow_active>:<allow_active>yes</allow_active>:g' $file;  done

