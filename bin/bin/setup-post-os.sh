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
ln -s ~thesaneone/.vim* .
ln -s ~thesaneone/.zsh* .
ln -s ~thesaneone/.zfun* .
ln -s ~thesaneone/.fzf* .

echo install node/pip packages
echo diff-so-fancy, mechanize, requests, conda
echo install nix os
echo install kali tools
echo setup caps:escape for dconf
echo install snaps: keepassxc, libreoffce
echo install nouveau vdpau and vaapi drivers, vdpau/vaapi utils
echo extract nvidia firmware for video accel and test out with mpv
echo setup kwin for compositing

