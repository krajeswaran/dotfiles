#!/bin/bash

# WOL should be generally disabled so that the machine can be shut down
# normally w/o the need to disable WOL manually.
# Otherwise, you may wonder why the box is powering on again after
# power off.

/sbin/ethtool -s $1 wol d
