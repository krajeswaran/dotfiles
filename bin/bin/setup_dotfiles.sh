#!/bin/sh

DOTFILES_PATH="${HOME}/dotfiles"

# execute os specific stuff first
[[ -e ${DOTFILES_PATH}/bin/setup-init-os.sh ]] && ${DOTFILES_PATH}/bin/setup-init-os.sh 

# execute stow on all config stored
for dirs in $(ls -d */)
do 
    stow -v3 ${dirs} -t ~/ # lame, what about other targets?
done

# execute post process for os
[[ -e ${DOTFILES_PATH}/bin/setup-init-os.sh ]] && ${DOTFILES_PATH}/bin/setup-done-os.sh

