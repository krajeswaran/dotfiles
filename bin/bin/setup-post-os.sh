#!/bin/bash

export BINPATH=${HOME}/dotfiles/bin/bin
source ${BINPATH}/common-lib.sh

echo "---------------- link home dirs -------------------------"
proceed
if [ $? -eq 0 ]; then
  # update user favs
  xdg-user-dirs-update

  # link dirs for root user
  sudo su
  ln -s ~${USER}/.config/nvim* .
  ln -s ~${USER}/.vim* .
  ln -s ~${USER}/.zsh* .
  ln -s ~${USER}/.zfun* .
  ln -s ~${USER}/.fzf* .
fi

echo "Here are things you might want to do: 
    x copy stuff from old home folder
    - OpensubtitlesDownloader.py
    - Setup wireguard/VPN
    - apt-repo: postgres older versions
    x awscli + eb setup
    - bitwarden
    - bluetooth devices connect
    - copy ~/dumps/ ~/src ~/videos ~/photos/ ~/.local/bin/ ~/music etc from old
    - disable klipper showing twice in systray: disable it in systray
    - dotfile syncup
    - firefoxpwa
    - fuck off with grub
    - hibernate stuff
    - homebrew install: xargs brew install < ~/bin/apps-brew.txt
    - install proj stuff: copy postgres db
    - install ufw, enable syncthing, ssh, samba + local network
    - pipewire
    - python install: pip3 install -r ~/bin/apps-pip.txt
    - setup backup cron/system
    - setup firefox dev + ublock
    - setup google-drive-ocamlfuse + setup keepassxc
    - setup local chromium
    - setup neovim: checkhealth, fix startup errors
    - syncthing setup + repos
    - toolbox: android-studio
    - toolbox: webstorm, intellij apps
    - touchpad not working
    - whatsapp/TG
    - yarn install: xargs yarn global install  < ~/bin/apps-yarn.txt
    x apt-repo: google-drive-ocamlfuse
    x apt-repo: keepassxc
    x apt-repo: librewolf
    x apt-repo: slack
    x firefox dev edition install
    x firefox/librewolf profile copy
    x fonts fuckery: install nerd-fonts: Hack, Jetbrains, Fira Sans
    x install stuff in ~/sw
    x keyboard shortcuts: handle caps lock <> esc
    x make sure fstab is hardlinked and updated
    x password, groups and sudoers
    x setup zsh, chsh
    x swap fn key with ctrl
    x uninstall crap
    x wifi
    x zhistory/root file history/sshkeys from old 
"
