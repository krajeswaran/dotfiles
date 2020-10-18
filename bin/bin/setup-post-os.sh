#!/bin/bash

export BINPATH=${HOME}/dotfiles/bin/bin
source ${BINPATH}/common-lib.sh

echo "---------------- Updating Vim -------------------------"
proceed
if [ $?	-eq 0 ]; then
    mkdir ${HOME}/.vimviews ${HOME}/.vimbackup ${HOME}/.vimswap
    vim +PlugInstall +qall
fi

# update user favs
xdg-user-dirs-update

# link dirs for root user
sudo su
mkdir ${HOME}/.vimviews ${HOME}/.vimbackup ${HOME}/.vimswap
ln -s ~${USER}/.vim* .
ln -s ~${USER}/.zsh* .
ln -s ~${USER}/.zfun* .
ln -s ~${USER}/.fzf* .

echo install umake, install umake go, node, firefox-dev
echo setup google chrome. setup firefox/chrome sync addons
echo install pyenv/pip packages: pgcli http-prompt ipython 
echo swap caps:escape make sure is working
echo setup compositing/vblank/mpv/xfdashboard
