#!/bin/bash

export BINPATH=${HOME}/dotfiles/bin/bin
source ${BINPATH}/common-lib.sh

echo "---------------- Removing packages  -------------------------"
proceed
if [ $?	-eq 0 ]; then
    sudo apt remove --purge $(<${BINPATH}/nope.txt)
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
    sudo apt install -t testing $(<${BINPATH}/apps.txt)	
fi

echo "---------------- Making user dirs -------------------------"
proceed
if [ $?	-eq 0 ]; then
    mkdir ~/src ~/docs ~/videos ~/photos ~/dumps ~/sw ~/music
fi

#echo "---------------- Updating dotfiles -------------------------"
#proceed
#if [[ $? = [yY] ]]; then
#    cd ~/dotfiles; git pull origin ${BRANCH}
#fi
