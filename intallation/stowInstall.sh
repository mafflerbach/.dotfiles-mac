#!/bin/bash

pacman -S --needed git base-devel zsh
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S --needed - < pacman.lst

wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

pip3 install requests tldextract pywal youtube-dl  pywal

# go get github.com/go-jira/jira/cmd/jira
curl -L https://github.com/gokcehan/lf/releases/latest/download/lf-linux-amd64.tar.gz | tar xzC ~/.local/bin

git clone git@github.com:mafflerbach/.dotfiles.git
cd .dotfiles

stow awesome
stow compton
stow goJira
stow kitty
stow misc
stow qutebrowser
stow rofi
stow scripts
stow tmux
stow vim2
stow zsh
