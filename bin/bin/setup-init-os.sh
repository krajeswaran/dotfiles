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
python
sshfs
node
tree
git
rsync
wget
pv
ctags
macvim --with-cscope --with-lua --with-ruby --with-python --HEAD
vim --with-cscope --with-lua --with-ruby --with-python
aria2 
cntlm
mitmproxy
xz 
openssh
mosh
)

echo "installing binaries..."
echo "installing apps..."
brew install ${binaries[@]}

# Apps
apps=(
dropbox
google-chrome
qlcolorcode
firefox
qlmarkdown
vagrant
iterm2
qlprettypatch
virtualbox
flux
qlstephen
mpv
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
font-clear-sans
font-source-code-pro 
font-terminus 
font-open-sans
font-droid-sans-mono
)

# install fonts
echo "installing fonts..."
brew cask install ${fonts[@]}
