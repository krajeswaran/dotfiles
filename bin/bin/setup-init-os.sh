#!/bin/bash

export BINPATH=${HOME}/dotfiles/bin/bin
source ${BINPATH}/common-lib.sh

echo "---------------- Updating dotfiles -------------------------"
proceed
if [[ $? = [yY] ]]; then
    cd ~/dotfiles; git pull origin ${BRANCH}
fi

echo "---------------- Removing packages  -------------------------"
proceed
if [ $?	-eq 0 ]; then
	for app in $(cat ${HOME}/dotfiles/bin/bin/nope.txt)
	do
            sudo apt remove --purge $app
	done
fi

echo "---------------- Upgrading installed packages  -------------------------"
proceed
if [ $?	-eq 0 ]; then
    sudo apt update; sudo apt upgrade
fi

echo "---------------- Installing packages  -------------------------"
proceed
if [ $?	-eq 0 ]; then
    echo "list --------- " ${PACKAGES}
	for app in $(cat ${HOME}/dotfiles/bin/bin/apps.txt)
	do
	    sudo apt install -y $app	
	done
fi

echo "---------------- Making user dirs -------------------------"
proceed
if [ $?	-eq 0 ]; then
    mkdir ~/src ~/docs ~/videos ~/photos ~/dumps ~/sw ~/music
fi

