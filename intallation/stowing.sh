#!/bin/bash

cd /home/maren/.dotfiles
rm ~/.config/awesome
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
