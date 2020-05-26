#!/bin/bash
#set -e

cd ./dotfiles
mkdir -p ~/.config/qtile
cp -rf autostart.sh config.py themes/ ~/.config/qtile
cp -rf Pictures/ ~/
mkdir -p ~/.config/nvim
cp -f init.vim ~/.config/nvim
mkdir -p ~/.config/alacritty
cp -rf alacritty.yml theme.py themes/ ~/.config/alacritty
mkdir -p ~/.config/rofi
cp -f config ~/.config/rofi
sudo cp -f DannMartinnez.rasi /usr/share/rofi/themes/
cp -f morc_menu_v1.conf ~/.config/morc_menu
cp -f .bashrc ~/
sudo cp avatar.jpg /var/lib/AccountsService/icons
# have in count dann in the next line is the username.
sudo echo Icon=/var/lib/AccountsService/icons/avatar.jpg >> /var/lib/AccountsService/users/dann 

