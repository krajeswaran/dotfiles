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
	for app in $(cat ${HOME}/dotfiles/bin/bin/nope.txt | sed 's/#.*//' | tr -d '[:blank:]')
	do
            sudo apt remove --purge $app
	done
fi

echo "---------------- Upgrading installed packages  -------------------------"
proceed
if [ $?	-eq 0 ]; then
    sudo apt update; sudo apt upgrade
fi

echo "---------------- Installing os packages  -------------------------"
proceed
if [ $?	-eq 0 ]; then
    echo "list --------- " ${PACKAGES}
	for app in $(cat ${HOME}/dotfiles/bin/bin/apps.txt | sed 's/#.*//' | tr -d '[:blank:]')
	do
	    sudo apt install -y $app	
	done
fi

echo "---------------- Installing nix packages  -------------------------"
proceed
if [ $?	-eq 0 ]; then
    echo "list --------- " ${PACKAGES}
	for app in $(cat ${HOME}/dotfiles/bin/bin/apps-nix.txt | sed 's/#.*//' | tr -d '[:blank:]')
	do
	    nix install $app	
	done
fi

echo "---------------- Making user dirs -------------------------"
proceed
if [ $?	-eq 0 ]; then
    mkdir ~/src ~/docs ~/videos ~/photos ~/dumps ~/sw ~/music
fi

