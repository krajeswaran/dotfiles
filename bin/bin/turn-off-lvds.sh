#!/bin/sh

sleep 2s

export XAUTHORITY=/home/thesaneone/.Xauthority 
export DISPLAY=:0

HDMI=$(xrandr | grep " connected" | grep HDMI | awk '{print $1}')
LVDS=$(xrandr | grep " connected" | grep LVDS | awk '{print $1}')
if [ "$HDMI" ]; then
    logger -t "TURNOFF" "disconnecting LVDS because HDMI is active"
    xrandr --output $LVDS --off
fi
