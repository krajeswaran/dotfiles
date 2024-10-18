#!/bin/bash

DOTFILES_PATH="${HOME}/dotfiles"

# execute os specific stuff first
[[ -e ${DOTFILES_PATH}/bin/bin/setup-init-os.sh ]] && ${DOTFILES_PATH}/bin/bin/setup-init-os.sh

# execute stow on all config stored
cd ${DOTFILES_PATH}
for dirs in $(printf "%s\n" */ | grep -v "^root-"); do
  echo ${dirs}
  stow -v3 --adopt ${dirs} -t ~/
done

git reset --hard

# execute post process for os
[[ -e ${DOTFILES_PATH}/bin/bin/setup-post-os.sh ]] && ${DOTFILES_PATH}/bin/bin/setup-post-os.sh
