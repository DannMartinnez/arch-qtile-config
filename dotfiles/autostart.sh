#!/bin/sh

monitors=`xrandr | grep -c ' connected'`
if [ $monitors = 2 ]; then
	xrandr --output HDMI-1 --primary --left-of LVDS-1 --output HDMI-1 --mode 1920x1080i --output LVDS-1 --mode 1280x720 --rotate left
fi

#start compton compositor
picom &
# set spanish keyborad
setxkbmap us
#tray icons
nm-applet &
blueman-tray &
volumeicon &
#automatic mount for usb devices
udiskie &

