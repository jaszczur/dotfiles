#!/usr/bin/env bash

target=$HOME
mkdir -p $target

function symlink() {
  ln -s $1 $target/$2
}

# VIM
symlink vim .vim
symlink vimrc .vimrc

# Emacs
which emacs && {
  echo "TODO: install Doom Emacs and my config files"
}

# VSCode
which code && {
 code --install-extension zhuangtongfa.Material-theme
 code --install-extension VSpaceCode.vspacecode
 code --install-extension CoenraadS.bracket-pair-colorizer-2
 code --install-extension usernamehw.errorlens
 code --install-extension dbaeumer.vscode-eslint
 code --install-extension esbenp.prettier-vscode
}

