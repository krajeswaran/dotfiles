#!/bin/sh

export DISPLAY=:0
export XAUTHORITY=/home/krajeswaran/.Xauthority

connect() {
    xrandr --output HDMI-1 --above LVDS-1 --preferred --primary --output LVDS-1 --preferred 
}

disconnect() { 
	xrandr --auto
}

xrandr | grep "HDMI-1 connected" &> /dev/null && connect || disconnect
