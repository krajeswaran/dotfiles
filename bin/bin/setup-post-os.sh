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
    - OpensubtitlesDownloader.py
    - awscli + eb setup
    - copy ~/dumps/ ~/sw/ etc from old
    - install proj stuff: copy postgres db
    - install ufw, enable syncthing, ssh, samba + local network
    - mozilla profiles from old
    x sleep/hybrid sleep issue
    - swap fn key with ctrl
    - zhistory/bash history from old 
    x bluetooth
    x keyboard shortcuts: handle caps lock <> esc
    x Setup wireguard/VPN
    x apt-repo: google-drive-ocamlfuse
    x apt-repo: keepassxc
    x apt-repo: librewolf
    x apt-repo: postgres older versions
    x apt-repo: slack
    x bitwarden
    x disable klipper showing twice in systray: disable it in systray
    x firefox dev edition install
    x firefoxpwa + librewolf
    x fonts fuckery: install nerd-fonts: Hack, Jetbrains, Fira Sans
    x fuck off with grub
    x gtk/xfce/kde themes: Materia theme, kvantum engine, cz-viator mouse cursor: https://store.kde.org/p/1229367/ etc
    x homebrew install: xargs brew install < ~/bin/apps-brew.txt
    x install stuff in ~/sw
    x make sure fstab is hardlinked and updated
    x password, groups and sudoers
    x pipewire
    x python install: pip3 install -r ~/bin/apps-pip.txt
    x setup firefox dev + ublock
    x setup google-drive-ocamlfuse + setup keepassxc
    x setup local chromium
    x setup neovim: checkhealth, fix startup errors
    x setup zsh, chsh
    x syncthing setup + repos
    x toolbox: android-studio
    x toolbox: webstorm, intellij apps
    x tz fuckery
    x uninstall crap
    x whatsapp/TG
    x wifi
    x yarn install: xargs yarn global install  < ~/bin/apps-yarn.txt
"
