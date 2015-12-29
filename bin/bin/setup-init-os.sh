#!/bin/sh

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

#TODO create default dirs: dumps, src .. + ln dotfiles to home

mkdir .vimviews .vimbackup .vimswap
cd ~/.vim && ./update_bundles

zsh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
chsh -s $(which zsh)

