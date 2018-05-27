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

echo install google chrome. setup firefox/chrome sync addons
echo install cool utils: fd, rg, diff-so-fancy, albert
echo install pyenv/pip packages: pgcli http-prompt neovim ipython jedi
echo "install js/npm packages: npm(already installed with node) term"
echo "swap caps:escape make sure is working"
echo setup kwin for compositing
