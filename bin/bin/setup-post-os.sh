#!/bin/bash

export BINPATH=${HOME}/dotfiles/bin/bin
source ${BINPATH}/common-lib.sh

echo "---------------- Updating Vim -------------------------"
proceed
if [ $?	-eq 0 ]; then
    mkdir ${HOME}/.vimviews ${HOME}/.vimbackup ${HOME}/.vimswap
    vim +PlugInstall +qall
fi

ln -s  ${HOME}/.vim/plugged/fzf/bin/fzf* .

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
    x unfuck dotfiles stowing
    x setup qbittorrent-nox svc
    x cp vlc prefs
    x install dns config
    x install deno
    x install yt-dlp
    x install sonarr
    x install jackett
    x setup backup crond
    - setup swapfile
    x get kdeconnect working
    x disable xscreensaver timeout
    x install jellyfin + config apps"
