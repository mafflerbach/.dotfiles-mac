#!/bin/bash
sudo pacman -Suy --needed git base-devel zsh exa
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd /home/maren/.dotfiles/intallation
yay -S --needed - < pacman.lst

yay -Suy go-yq-bin

pip3 install requests tldextract pywal youtube-dl  pywal

go get github.com/go-jira/jira/cmd/jira

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh

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

rm ~/.zshrc
stow zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

rm ~/.Xresources
rm ~/.xinitrc
stow xinit

touch ~/exportedVars
touch ~/.dotfiles/misc/.credencials
