#!/bin/bash

export BINPATH=${HOME}/dotfiles/bin/bin
source ${BINPATH}/common-lib.sh

echo "---------------- Updating Vim -------------------------"
proceed
if [ $? -eq 0 ]; then
	mkdir ${HOME}/.vimviews ${HOME}/.vimbackup ${HOME}/.vimswap
	vim +PlugInstall +qall
fi

echo "---------------- link home dirs -------------------------"
proceed
if [ $? -eq 0 ]; then
	# update user favs
	xdg-user-dirs-update

	# link dirs for root user
	sudo su
	mkdir ${HOME}/.vimviews ${HOME}/.vimbackup ${HOME}/.vimswap
	ln -s ~${USER}/.config/nvim* .
	ln -s ~${USER}/.vim* .
	ln -s ~${USER}/.zsh* .
	ln -s ~${USER}/.zfun* .
	ln -s ~${USER}/.fzf* .
fi

echo "Here are things you might want to do: 
    - password, groups and sudoers
    - uninstall crap
    - setup extra repos
    - download and install: ungoogled-chromium
    - apt-repo: librewolf
    - apt-repo: postgres older versions
    - apt-repo: google-drive-ocamlfuse
    - unfuck dotfiles stowing
    - install additional ppas/backports
    - homebrew install: xargs brew install < ~/bin/apps-brew.txt
    - python install: pip3 install -r ~/bin/apps-pip.txt
    - yarn install: xargs yarn global install  < ~/bin/apps-yarn.txt
    - flatpak install:  xargs flatpak install < ~/bin/apps-flatpak.txt
    - setup neovim: checkhealth
    - setup google-drive-ocamlfuse + setup keepassxc
    - keyboard shortcuts
    - setup local firefox, ungoogled-chromium
    - gtk/xfce/kde themes: Layan theme, kvantum engine, cz-viator mouse cursor: https://store.kde.org/p/1229367/ etc
    - install android-studio, install android-sdk
    - postgres, redis
    - install proj stuff
    - syncthing setup
    - fonts fuckery: install nerd-fonts: Hack, Jetbrains, Fira Sans
    - install ufw, enable syncthing, ssh, samba + local network
    - OpensubtitlesDownloader.py
"
