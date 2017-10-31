#!/bin/bash
export DISPLAY=:0
xrandr -s 1920x1080
exec x11vnc -forever -display :0 -nopw -repeat -noxrecord \
     -auth /var/run/lightdm/root/:0 -display :0 "$@"
