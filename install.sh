#!/usr/bin/env zsh

DIR=${0:A:h}
OLDDIR=`pwd`

cd $DIR/dotfiles
for dotfile in **/*; do
  fullPath=$HOME/$dotfile;
  mkdir -p $(dirname $fullPath);
  ln -s $DIR/dotfiles/$dotfile $fullPath;
done;
# Vim-Plug Install
curl -fLo ~/.nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugInstall +qall

cd $OLDDIR
