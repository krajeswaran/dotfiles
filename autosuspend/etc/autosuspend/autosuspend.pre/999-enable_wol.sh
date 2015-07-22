#!/bin/bash

# obviously needed to enable wake on lan

# wake types
#	p	Wake on PHY activity
#	u	Wake on unicast messages
#	m	Wake on multicast messages
#	b	Wake on broadcast messages
#	a	Wake on ARP
#	g	Wake on MagicPacket™
#	s	Enable SecureOn™ password for MagicPacket™
#	d	Disable (wake on  nothing).   This  option
#		clears all previous options.
#
# check supported modes with `ethtool eth0|grep "Supports Wake"`

WAKE_ON=ug

/sbin/ethtool -s $1 wol $WAKE_ON
