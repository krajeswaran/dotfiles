#!/bin/bash

# commandline checking
S1='d'
S2='r'

# Backup destination
backdest=${HOME}/backups
mkdir -p "$backdest"

# Labels for backup name
pc=${HOSTNAME}
distro=$(lsb_release -s -i)
distro_release=$(lsb_release -s -c)
date=$(date "+%F")
backupfile="$backdest/$pc-$distro-$distro_release-$date.tar.gz"

# Exclude file location
exclude_file="${HOME}/.config/backup-excludes.cfg"

#Check if run as root
ROOT_UID="0"
if [ "$UID" -ne "$ROOT_UID" ] ; then
    echo "You must be root run this!"
    exit 1
fi

proceed_yesorno() {
    # check daemon mode
    [[ "$1" = "$S1" ]] && REPLY='y' && return
    read -n1 -p "(y/n/q)? -- " 
    echo
    [[ $REPLY = [qQ] ]] && echo "Terminating..." && exit -1
}

if [ "$1" = "$S2" ]; then
    echo "WARNING: This will wreak hell and havoc upon thy drive."
    proceed_yesorno
    echo "Please enter the full path of the archive to restore -- "        
    read fileName
    echo "Just sit back and watch the fireworks.This might take a while. When it is done, you have a fully restored system!"
    tar xzvpf $fileName -C /

    #Just to make sure that all excluded directories are re-created
    echo "Creating excluded directories"    
    mkdir /proc
    mkdir /lost+found
    mkdir /mnt
    mkdir /sys
    mkdir /dev
    mkdir /tmp
    chmod 777 /tmp
    mkdir /run
    mkdir /media
    mkdir /var/log
    mkdir /var/cache
    mkdir /var/tmp
    mkdir /var/run
    mkdir /var/crash
    echo "Remember to edit /etc/fstab and /boot files !!!"
    echo "-----------------#-----*----------#@****** ALL DONE! HAVE FUN! OR NOT! -----------##########--------------------------"
    exit 
fi     

# bleachbit commandline stuff
echo Bleachbit your dirty bits.......
proceed_yesorno
[[ $REPLY = [yY] ]] && bleachbit -c --preset

echo Optimizing apt.......
proceed_yesorno
[[ $REPLY = [yY] ]] && apt autoremove --purge && apt autoclean

#echo Purging old kernels........
#proceed_yesorno
#[[ $REPLY = [yY] ]] && dpkg -l linux-'*' | awk '/^ii/{ print $2}' | grep -v -e $(uname -r | cut -f1,2 -d"-") | grep -e [0-9] | xargs apt purge

echo Purging dead config........
proceed_yesorno
[[ $REPLY = [yY] ]] && dpkg --purge $(dpkg -l | grep ^rc | tr -s ' ' | cut -d " " -f 2)

# Check if exclude file exists
if [ ! -f $exclude_file ]; then
    echo "Excludes file is missing, so everything will be backed up. This is BAD. Continue..." 
    proceed_yesorno
    [[ $REPLY != [yY] ]] && exit
fi

# print possible backup file size and home dir size
echo Calculating filesystem size........
du -h -d 2 --exclude-from=$exclude_file /
echo Does this look okay?
proceed_yesorno
[[ $REPLY != [yY] ]] && exit

cd /

echo "Backing up to $backupfile"

tar --exclude-from=$exclude_file -czpvf $backupfile /

