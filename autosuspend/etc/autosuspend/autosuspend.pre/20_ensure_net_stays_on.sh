#!/bin/bash

# required because we do not want network interfaces to be powered off
# (would disable wake on lan)

exit $(( $(cat /etc/default/halt | \
    tr -d " \t" | \
    grep -c "^NETDOWN=*no*" /etc/default/halt) - 1 ))
