#!/bin/bash

#echo "############## installing permissions... #####################"
#for dir in "/usr/local/* /usr/local/bin/* /usr/local/include/* /usr/local/lib/* /usr/local/share/*"; do
#	sudo chgrp admin $dir
#	sudo chmod g+w $dir
#done
#
## homebrew
#
## Check for Homebrew,
## Install if we don't have it
#if test ! $(which brew); then
#    echo "Installing homebrew..."
#    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#fi
#
## Update homebrew recipes
#brew install caskroom/cask/brew-cask
#brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup

# it gets annoying after that
export HOMEBREW_NO_AUTO_UPDATE=1

echo "############## installing binaries... #####################"
for app in $(cat ${HOME}/dotfiles/bin/bin/utils.txt)
do
    brew install ${app}
done

# Apps
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
echo "############## installing apps... #####################"
for app in $(cat ${HOME}/dotfiles/bin/bin/apps.txt)
do
    brew install ${app}
done

brew tap caskroom/fonts

brew tap "gapple/services"

brew tap caskroom/versions

# fonts
fonts=(
font-source-code-pro 
font-hack-nerd-font
font-fira-code
)

echo "############## installing fonts... #####################"
brew  install ${fonts[@]}

# create vim dirs
# install vim plugs
