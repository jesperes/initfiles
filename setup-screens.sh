#!/bin/sh

case $1 in
    home)
	xrandr -s 1920x1080
	xrandr --output HDMI2 --off
	;;
    office)
	xrandr -s 1920x1200
	xrandr --output HDMI2 --auto --right-of HDMI1
	;;
    *)
	echo "Unknown location: $where"
	;;
esac
