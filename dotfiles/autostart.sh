#!/bin/sh

#start compton compositor
picom &
# set spanish keyborad
setxkbmap es
#tray icons
nm-applet &
blueman-tray &
volumeicon &
#automatic mount for usb devices
udiskie &
