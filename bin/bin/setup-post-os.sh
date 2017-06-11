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

# install node/pip packages
# diff-so-fancy, ipython, mechanize

