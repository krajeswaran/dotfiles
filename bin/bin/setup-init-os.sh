#!/bin/sh

proceed_yesorno() {
    # check daemon mode
    [[ "$1" = "$S1" ]] && REPLY='y' && return
    read -n1 -p "(y/n/q)? -- " 
    echo
    [[ $REPLY = [qQ] ]] && echo "Terminating..." && exit -1
}

PACKAGES=(
git
vim-gtk
cscope
exuberant-ctags
mpv
curl
wget
aria2
terminator
build-essential
libz32-dev
stow
sshfs
mosh
rsync
watch
pv
libreoffice-draw
graphicsmagick
zsh
zsh-doc
vim-doc
p7zip
unrar
gparted
gnome-paint
zip
ia32-libs
lib32z1
lib32z1-dev
lib32stdc++6
lib32ncurses5-dev
bleachbit
djmount
redshift
ranger
xfce4-clipman-plugin
highlight
htop
rbenv
openjdk-8-jdk
ruby 
ruby2.2 
ipython3 
virtualenv 
nodejs 
xfce4-time-out-plugin
)

REMOVE=(
thunderbird
apport
vim-tiny
xfce4-verve-plugin
xfce4-notes
yelp
yelp-xsl
transmission-common
gnome-sudoku
gnome-mines
gnome-user-guide
parole
gmusicbrowser
sane-utils
simple-scan
)

echo "---------------- Removing packages  -------------------------"
proceed_yesorno
if [[ $REPLY = [yY] ]]; then
    sudo apt-get remove --purge $REMOVE
fi

echo "---------------- Upgrading installed packages  -------------------------"
proceed_yesorno
if [[ $REPLY = [yY] ]]; then
    sudo apt-get update; sudo apt-get upgrade
fi

echo "---------------- Installing packages  -------------------------"
proceed_yesorno
if [[ $REPLY = [yY] ]]; then
    sudo apt-get install $PACKAGES
fi

echo "---------------- Making user dirs -------------------------"
proceed_yesorno
if [[ $REPLY = [yY] ]]; then
    mkdir ~/src ~/docs ~/videos ~/photos ~/dumps ~/sw
fi

echo "---------------- Updating Vim -------------------------"
proceed_yesorno
if [[ $REPLY = [yY] ]]; then
    mkdir .vimviews .vimbackup .vimswap
    cd ~/.vim && ./update_bundles
fi

echo "---------------- Updating dotfiles -------------------------"
proceed_yesorno
if [[ $REPLY = [yY] ]]; then
    cd ~/dotfiles; git pull origin ubuntu
fi

echo "---------------- setting up zprezto -------------------------"
proceed_yesorno
if [[ $REPLY = [yY] ]]; then
    zsh
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done
    chsh -s $(which zsh)
fi
