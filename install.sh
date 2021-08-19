#!/usr/bin/env bash

target=${1:-$HOME}
mkdir -p $target

function install_to_target() {
  cp -R $1 $target/$2
}

# VIM
install_to_target vim .vim
install_to_target vimrc .vimrc

# Emacs
which emacs && {
  echo "TODO: install Doom Emacs and my config files"
}

# VSCode
which code && {
  echo "installing VSCode extensions"
  code --install-extension zhuangtongfa.Material-theme
  code --install-extension VSpaceCode.vspacecode
  code --install-extension CoenraadS.bracket-pair-colorizer-2
  code --install-extension usernamehw.errorlens
  code --install-extension dbaeumer.vscode-eslint
  code --install-extension esbenp.prettier-vscode
}

