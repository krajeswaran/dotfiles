#!/bin/bash

export BINPATH=${HOME}/dotfiles/bin/bin
source ${BINPATH}/common-lib.sh
ORIGUSER=${USER}

echo "---------------- Updating dotfiles -------------------------"
proceed
if [[ $? = [yY] ]]; then
  cd ~/dotfiles
  git pull origin ${BRANCH}
fi

echo "---------------- Removing packages  -------------------------"
proceed
if [ $? -eq 0 ]; then
  for app in $(cat ${HOME}/dotfiles/bin/bin/nope.txt | sed 's/#.*//' | tr -d '[:blank:]'); do
    sudo apt remove --purge $app
  done
fi

echo "---------------- Upgrading installed packages  -------------------------"
proceed
if [ $? -eq 0 ]; then
  sudo apt update
  sudo apt upgrade
fi

echo "---------------- Installing os packages  -------------------------"
proceed
if [ $? -eq 0 ]; then
  echo "list --------- " ${PACKAGES}
  for app in $(cat ${HOME}/dotfiles/bin/bin/apps.txt | sed 's/#.*//' | tr -d '[:blank:]'); do
    sudo apt install -y $app
  done
fi

echo "---------------- Making user dirs -------------------------"
proceed
if [ $? -eq 0 ]; then
  mkdir ~/src ~/docs ~/videos ~/photos ~/dumps ~/sw ~/music
  # update user favs
  xdg-user-dirs-update
fi

echo "---------------- link home dirs to root -------------------------"
proceed
if [ $? -eq 0 ]; then
  # link dirs for root user
  sudo su
  ln -s ~${ORIGUSER}/.config/nvim* .
  ln -s ~${ORIGUSER}/.vim* .
  ln -s ~${ORIGUSER}/.zsh* .
  ln -s ~${ORIGUSER}/.zfun* .
  ln -s ~${ORIGUSER}/.fzf* .
  exit
fi
