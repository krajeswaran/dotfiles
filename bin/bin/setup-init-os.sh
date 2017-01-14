#!/bin/bash


# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

brew tap "homebrew/dupes"
brew tap "gapple/services"
brew tap "universal-ctags/universal-ctags"

echo "installing binaries..."
brew install $(<${HOME}/dotfiles/bin/bin/utils.txt)

# Apps
# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" $(<${HOME}/dotfiles/bin/bin/apps.txt)

brew tap caskroom/fonts

brew tap caskroom/versions

# fonts
fonts=(
font-lato
font-clear-sans
font-source-code-pro 
font-terminus 
font-open-sans
font-droid-sans-mono
)

# install fonts
echo "installing fonts..."
brew cask install ${fonts[@]}

brew linkapps --system

# create vim dirs
# install vim plugs
