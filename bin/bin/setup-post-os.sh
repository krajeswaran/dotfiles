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
    - firefox-dev
    - unfuck dotfiles stowing
    - homebrew install: xargs brew install < ~/bin/apps-brew.txt
    - python install: pip3 install -r ~/bin/apps-pip.txt
    - yarn install: xargs yarn global install  < ~/bin/apps-yarn.txt
    - flatpak install:  xargs flatpak install < ~/bin/apps-flatpak.txt
    - setup neovim: checkhealth
    - setup google-drive-ocamlfuse + setup keepassxc
    - keyboard shortcuts
    - binaries: fd, rg, bat, lsd, duf, dust, delta, bottom. See: https://github.com/ibraheemdev/modern-unix
    - setup local firefox, ungoogled-chromium
    - gtk/xfce/kde themes, greeter config, icon themes
    - f12 console
    - install android-studio, install android-sdk
    - postgres, redis
    - install proj stuff
    - syncthing setup
    - fonts fuckery: get nerd-fonts: Hack, Jetbrains, Fira
    - playx + instantmusic + musickube
"
