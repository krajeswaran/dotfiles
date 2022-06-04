#!/bin/bash

export BINPATH=${HOME}/dotfiles/bin/bin
source ${BINPATH}/common-lib.sh

echo "---------------- Updating Vim -------------------------"
proceed
if [ $?	-eq 0 ]; then
    mkdir ${HOME}/.vimviews ${HOME}/.vimbackup ${HOME}/.vimswap
    vim +PlugInstall +qall
fi

echo "---------------- link home dirs -------------------------"
proceed
if [ $?	-eq 0 ]; then
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
    - download and install: firefox-dev
    - apt-repo: pop apps
    - apt-repo: librewolf
    - apt-repo: postgres older versions
    - apt-repo: google-drive-ocamlfuse
    - unfuck dotfiles stowing
    - install additional ppas/backports
    - install missing base apps: pdfviewer etc
    - homebrew install: xargs brew install < ~/bin/apps-brew.txt
    - python install: pip3 install -r ~/bin/apps-pip.txt
    - yarn install: xargs yarn global install  < ~/bin/apps-yarn.txt
    - flatpak install:  xargs flatpak install < ~/bin/apps-flatpak.txt
    - setup neovim: checkhealth
    - setup google-drive-ocamlfuse + setup keepassxc
    - keyboard shortcuts
    - setup local firefox, ungoogled-chromium
    - gtk/xfce/kde themes, kvantum engine etc
    - install android-studio, install android-sdk
    - postgres, redis
    - install proj stuff
    - syncthing setup
    - fonts fuckery: install nerd-fonts: Hack, Jetbrains, Fira Sans
    - playx + instantmusic + musickube
"
