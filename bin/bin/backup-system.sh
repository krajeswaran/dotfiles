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
    echo "Just sit back and watch the fireworks.This might take a while. When it is done, you have a fully restored system!"
    tar xzvpf "$2" -C "$3"/

    #Just to make sure that all excluded directories are re-created
    echo "Creating excluded directories"    
    mkdir "$3"/proc
    mkdir "$3"/lost+found
    mkdir "$3"/mnt
    mkdir "$3"/sys
    mkdir "$3"/dev
    mkdir "$3"/tmp
    mkdir "$3"/run
    mkdir "$3"/media
    mkdir "$3"/var/log
    mkdir "$3"/var/cache
    mkdir "$3"/var/tmp
    mkdir "$3"/var/crash
    chmod 777 "$3"/tmp
    ln -s "$3"/run "$3"/var/run
    ln -s "$3"/run/lock "$3"/var/run/lock
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

echo Purging journalctl.......
proceed_yesorno
[[ $REPLY = [yY] ]] && journalctl --vacuum-time=1

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

