#!/bin/bash
func_install(){
	if pacman -Qi $1 &> /dev/null; then
		echo "$1" >> ./PreviouslyInstalled.log
	else
		if [ $1 = "yay" ]; then
			echo "#######################################"
			echo "Installing yay"
			echo "#######################################"
			git clone https://aur.archlinux.org/yay.git
			cd yay
			makepkg -s --noconfirm --needed
			sudo pacman -U --noconfirm --needed yay*.pkg.tar*
			cd ..
			rm -rf yay
			echo "$1" >> ./JustInstalled.log
		else
			tput setaf 12
			echo "############################################################################"
			echo "############### Installing package" $1
			echo "############################################################################"
			tput sgr0
			yay -S --noconfirm --needed $1
			if pacman -Qi $1 &> /dev/null; then
				echo "$1" >> ./JustInstalled.log
			else
				echo "$1" >> .NotInstalled.log
			fi
		fi
	fi
}

list=(
yay
google-chrome
pamac-aur
visual-studio-code-bin
ttf-twemoji-color
ttf-ms-fonts
file-roller
simplenote-electron-bin
popcorntime
notepadpp
la-capitaine-icon-theme
)

now=`date +"%B %d %Y %H:%M"`

files=(
Previously
Just
Not
)


for file in "${files[@]}"; do
	echo "#############################################" >> "$file""Installed.log"
	echo "This log was generated on "${now} >> "$file""Installed.log"
done

for name in "${list[@]}" ; do
        func_install $name
done


tput setaf 10;
echo "################################################################"
echo "The installation has finished, for more information you can review the .log files in this directory that have been updated."
echo "################################################################"
echo;tput sgr0
