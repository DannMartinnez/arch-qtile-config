#!/bin/bash
#set -e

#Daniel Martinez

###############################################################################
###############################################################################
#
#   TAKE A MOMENT TO REVIEW WHAT YOU ARE GOING TO INSTALL
#
###############################################################################

#   DECLARATION OF FUNCTIONS

func_install() {
	if pacman -Qi $1 &> /dev/null; then
		echo "$1" >> ./PreviouslyInstalled.log
		if [ $1 = "lightdm" ]; then
			activateservice=$(($activateservice*2))
		fi
		if [ $1 = "bluez" ]; then
			activateservice=$(($activateservice*3))
		fi
		if [ $1 = "cups" ]; then
			activateservice=$(($activateservice*4))
		fi

	else
    		tput setaf 12
    		echo "###############################################################################"
    		echo "##################  Installing package "  $1
    		echo "###############################################################################"
    		echo
    		tput sgr0
    		sudo pacman -S --noconfirm --needed $1
		if [ $? -eq 0 ]; then
			echo "$1" >> ./JustInstalled.log
		else
			echo "$1" >> ./NotInstalled.log
			tput setaf 9
    			echo "###############################################################################"
    			echo "##################  The package "  $1 could not be installed
    			echo "###############################################################################"
    			echo
	    		tput sgr0

		fi
	fi
}

tput setaf 14 
echo "##############################################################################"
echo "Installation of the software packages"
echo "##############################################################################"
tput sgr0

list=(
#display manager
xorg-server
xorg-apps
xterm
lightdm
qtile
arandr
python-psutil
#Graphics and Multimedia
flameshot
gimp
nomacs
vlc
peek
imagemagick
feh
#sound
pulseaudio
pulseaudio-alsa
pavucontrol
alsa-firmware
alsa-lib
alsa-plugins
alsa-utils
gstreamer
gst-plugins-good
gst-plugins-bad
gst-plugins-base
gst-plugins-ugly
playerctl
volumeicon
gnome-sound-recorder
#bluethoot
pulseaudio-bluetooth
bluez
bluez-libs
bluez-utils
blueman
#network
avahi
wireless_tools
network-manager-applet
nss-mdns
#printer software
cups
cups-pdf
ghostscript
gsfonts
gutenprint
gtk3-print-backends
libcups
system-config-printer
#Development
meld
git
#internet
qbittorrent
#Pack-Unpack
unace
unrar
zip
unzip
sharutils
uudeview
arj
cabextract
#system
lxappearance
man
udisks2
udiskie
xfce4-notifyd
picom
neovim
alacritty
pcmanfm
vifm
rofi
htop
neofetch
okular
#fonts
awesome-terminal-fonts
adobe-source-sans-pro-fonts
cantarell-fonts
noto-fonts
ttf-bitstream-vera
ttf-dejavu
ttf-droid
ttf-hack
ttf-inconsolata
ttf-liberation
ttf-roboto
ttf-ubuntu-font-family
tamsyn-font
)

files=(
Previously
Just
Not
)

activateservice=1
i=0
content="was already"
now=`date +"%B %d %Y %H:%M"`

for file in "${files[@]}"; do
        if [ -f "$file""Installed.log" ]; then
                rm "$file""Installed.log"
        fi
        if [ $i = 0 ]; then
                echo "The names in this log correspond to the software that "$content" installed" >> "$file""Installed.log"
                content="just been installed"
                i=1
        elif [ $i = 1 ]; then
                echo "The names in this log correspond to the software that "$content" installed" >> "$file""Installed.log"
                content="could not be installed"
                i=2
        elif [ $i = 2 ]; then
                echo "The names in this log correspond to the software that "$content" installed" >> "$file""Installed.log"
        fi
        echo "This log was generated on "${now} >> "$file""Installed.log"
done

for name in "${list[@]}" ; do
	func_install $name
done


if [ $(($activateservice%2)) -eq 0 ]; then
	tput setaf 5;echo "################################################################"
	echo "Enabling lightdm as display manager"
	echo "################################################################"
	echo;tput sgr0
	sudo systemctl enable lightdm.service -f
fi

if [ $(($activateservice%3)) -eq 0 ]; then
	tput setaf 5;echo "################################################################"
	echo "Enabling bluetooth services"
	echo "################################################################"
	echo;tput sgr0
	sudo systemctl enable bluetooth.service
	sudo systemctl start bluetooth.service
	sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf
fi

if [ $(($activateservice%5)) -eq 0 ]; then
	tput setaf 5;echo "################################################################"
	echo "Enabling services"
	echo "################################################################"
	echo;tput sgr0
	sudo systemctl enable org.cups.cupsd.service
fi


tput setaf 10;
echo "################################################################"
echo "The installation has finished, for more information you can review the .log files that have been generated in this directory."
echo "################################################################"
echo;tput sgr0


###############################################################################
# special thanks to Erik Dubois https://github.com/erikdubois
