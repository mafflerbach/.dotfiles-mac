#!/bin/bash
sudo pacman -Suy --needed git base-devel zsh exa
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd /home/maren/.dotfiles/intallation
yay -S --needed - < pacman.lst

yay -Suy go-yq-bin
yay -Suy ttf-material-design-icons-git
pip3 install requests tldextract pywal youtube-dl  pywal

go get github.com/go-jira/jira/cmd/jira

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh

