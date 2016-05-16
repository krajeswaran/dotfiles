#!/bin/sh

export DISPLAY=:0
export XAUTHORITY=/home/krajeswaran/.Xauthority

connect() {
    xrandr --output HDMI-1-1 --above LVDS2 --preferred --primary --output LVDS2 --preferred 
}

disconnect() { 
	xrandr --auto
}

xrandr | grep "HDMI-1-1 connected" &> /dev/null && connect || disconnect
