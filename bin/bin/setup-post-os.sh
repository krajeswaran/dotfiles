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
    x make sure fstab is hardlinked and updated
    x password, groups and sudoers
    x setup zsh, chsh
    - swap fn key with ctrl
    - fuck off with grub
    - fix nvim startup
    - uninstall crap
    - install stuff in ~/sw
    x firefox dev edition install
    x setup firefox dev + ublock
    x apt-repo: librewolf
    x apt-repo: keepassxc
    - apt-repo: slack
    x apt-repo: google-drive-ocamlfuse
    - apt-repo: postgres older versions
    - apt-repo: webstorm, intellij apps
    - apt-repo: android-studio
    - bluetooth
    - pipewire
    - wifi
    - homebrew install: xargs brew install < ~/bin/apps-brew.txt
    - python install: pip3 install -r ~/bin/apps-pip.txt
    - yarn install: xargs yarn global install  < ~/bin/apps-yarn.txt
    - setup local chromium
    - setup neovim: checkhealth
    x setup google-drive-ocamlfuse + setup keepassxc
    - keyboard shortcuts: handle fn/caps lock keys
    - gtk/xfce/kde themes: Materia theme, kvantum engine, cz-viator mouse cursor: https://store.kde.org/p/1229367/ etc
    - install proj stuff
    - syncthing setup
    - fonts fuckery: install nerd-fonts: Hack, Jetbrains, Fira Sans
    - install ufw, enable syncthing, ssh, samba + local network
    - OpensubtitlesDownloader.py
"
