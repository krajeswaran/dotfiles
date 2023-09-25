#!/bin/sh

sudo mount -o rbind /boot/efi $1/boot/efi
sudo mount -o rbind /proc $1/proc
sudo mount -o rbind /dev $1/dev
sudo mount -o rbind /dev/pts $1/dev/pts
sudo mount -o rbind /sys $1/sys
sudo mount -o rbind /run $1/run
sudo cp /etc/resolv.conf $1/etc/resolv.conf
sudo chroot $1 /bin/bash
