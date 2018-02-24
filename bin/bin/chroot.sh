#!/bin/sh

mount -o bind /proc $1/proc
mount -o bind /dev $1/dev
mount -o bind /dev/pts $1/dev/pts
mount -o bind /sys $1/sys
cp /etc/resolv.conf $1/etc/resolv.conf
chroot $1 /bin/bash
