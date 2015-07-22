#!/bin/bash

# We just grab a new DHCP lease here. Mainly to refresh the routers
# ARP cache and to reset the DHCP lease life time.

[ -f '/var/run/dhclient-$1.pid' ] || exit 0

dhclient -r $1
dhclient $1
