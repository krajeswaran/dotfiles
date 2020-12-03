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

echo "Here are things you might want to do: 
    - unfuck dotfiles stowing
	- asdf install: yarn, golang, python, node
	- pip install: pgcli, ipython, pynvim
	- yarn install: diff-so-fancy
	- setup neovim: checkhealth
	- install gdrive, setup keepassxc
	- keyboard shortcuts
	- firefox-dev
	- setup local firefox, chromium
	- gtk/xfce/kde themes, greeter config, icon themes
	- f12 console
	- install android-studio, install android-sdk
	- postgres, redis
	- install proj stuff
	- syncthing setup
    - fonts fuckery: get nerd-fonts: rxvt, gvim, neovim
	- playx + instantmusic + musickube
	- lsd
"
