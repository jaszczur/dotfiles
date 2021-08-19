#!/usr/bin/env bash

target=/tmp/dupa
mkdir -p $target

function symlink() {
  ln -s $1 $target/$2
}

# VIM
symlink vim .vim
symlink vimrc .vimrc
vim +qall

# Emacs
which emacs && {
  echo "TODO: install Doom Emacs and my config files"
}

