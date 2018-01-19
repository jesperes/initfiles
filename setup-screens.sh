#!/bin/sh
#
# Sets up correct screen configuration depending on from where I'm
# working.
#
# This was written as a workaround to the problems described here:
# https://github.com/linuxmint/Cinnamon/issues/6224. The display
# applet in Linux Mint causes system freeze when attempting to
# move/resize displays.
#
# TODO Try to do
#
# apt remove xserver-xorg-video-intel
#

if [ "x$1" = x ]; then
    echo "Usage: $0 [home|office]"
fi

case $1 in
    # This is my home configuration where I use nxmachine to access
    # the machine located in the IAR Uppsala office. This is a single
    # 1920x1080 external screen connected to a laptop. I typically
    # have the laptop screen switched off.
    home)
	xrandr -s 1920x1080
	xrandr --output HDMI2 --off
	;;

    # Configuration for my office at IAR (Uppsala). This is where the
    # physical hardware is located. I have two monitors, typically
    # arranged as one center and one to the right.
    iar-uppsala)
	xrandr -s 1920x1200
	xrandr --output HDMI2 --auto --right-of HDMI1
	;;
    *)
	echo "Unknown location: $where"
	;;
esac
