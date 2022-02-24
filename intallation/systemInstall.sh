#!/bin/bash
yay -Suy --needed - < pacman.lst

pacman -S exa
pacman -S pass

pip3 install requests tldextract pywal youtube-dl  pywal

go get github.com/go-jira/jira/cmd/jira

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

chmod 777 ~/.dotfiles/scripts/.local/bin/collection/*

#git clone https://github.com/mmerfort/cato_pkgbuild
#cd cato_pkgbuild
#makepkg -si


wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh

