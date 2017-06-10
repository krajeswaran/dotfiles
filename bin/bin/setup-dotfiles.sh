#!/bin/bash

DOTFILES_PATH="${HOME}/dotfiles"

# execute os specific stuff first
[[ -e ${DOTFILES_PATH}/bin/bin/setup-init-os.sh ]] && ${DOTFILES_PATH}/bin/bin/setup-init-os.sh

# execute stow on all config stored
cd ${DOTFILES_PATH}
for dirs in $(printf "%s\n" */)
do 
	echo ${dirs}
	stow -v3 ${dirs} -t ~/
done

# execute post process for os
[[ -e ${DOTFILES_PATH}/bin/bin/setup-post-os.sh ]] && ${DOTFILES_PATH}/bin/bin/setup-post-os.sh

