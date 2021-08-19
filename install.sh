#!/usr/bin/env bash

function symlink() {
  ln -s $1 $HOME/$2
}

symlink vim .vim
symlink vimrc .vimrc

