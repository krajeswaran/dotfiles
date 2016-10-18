#!/bin/bash


# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

brew tap homebrew/dupes
brew tap gapple/services

binaries=(
coreutils
findutils
binutils
stow
homebrew/dupes/grep
graphicsmagick
rename
zsh
python
node
tree
git
rsync
cscope
curl
wget
progress
ctags
macvim --with-cscope --with-lua --with-ruby --with-python --HEAD
vim --with-cscope --with-lua --with-ruby --with-python
ack
p7zip
unrar
aria2 
xz 
openssh
mosh
golang
python3
)

echo "installing binaries..."
echo "installing apps..."
brew install ${binaries[@]}

# Apps
apps=(
dropbox
java
qlcolorcode
firefox
qlmarkdown
vagrant
iterm2
qlprettypatch
virtualbox
qlstephen
mpv
sshfs
quicklook-json
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

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

#brew linkapps --system
