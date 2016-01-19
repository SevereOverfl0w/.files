#!/usr/bin/env zsh

DIR=${0:A:h}
OLDDIR=`pwd`

autoload -U colors; colors;
start(){
  print "$fg_bold[blue]Starting $1.$reset_color";
}

ending(){
  print "$fg_bold[magenta]Ending $1.$reset_color";
}

# Basic install of packages for Arch
# echo 'Starting package install.'
# start 'package install'
# sudo pacman --needed -S xmonad xmobar dmenu stalonetray
# if [[ ! -a /usr/bin/apacman ]]; then;
#   # Install apacman
#   cd /tmp
#   curl -O https://aur.archlinux.org/packages/ap/apacman/apacman.tar.gz
#   tar -xvf apacman.tar.gz
#   cd apacman
#   makepkg -s
#   sudo pacman -U apacman*.tar.xz
# fi;
# apacman --needed --noedit -S scrot-patched neovim-git python2-neovim
# ending 'package install.'

start 'symlinking of dotfiles'
cd $DIR/dotfiles
for dotfile in **/*(D); do
  fullPath=$HOME/$dotfile;
  srcPath=$DIR/dotfiles/$dotfile;
  mkdir -p $(dirname $fullPath);
  if [[ -f $fullPath ]]; then;
    if [[ -h $fullPath ]]; then;
      print "$fg_bold[yellow]Symlink already exists $dotfile$reset_color"
    else;
      print "$fg_bold[red]Non-Symlink file exists: $dotfile$reset_color"
      print -n "Remove and replace with symlink? (y/n) " 
      read -q replace
      print ""
      if [[ $replace == 'y' ]]; then;
        rm $fullPath
        ln -s $srcPath $fullPath
        print "$fg_bold[yellow] Replaced with symlink."
      fi;
    fi;
  else;
    if [[ ! -a $fullPath ]]; then;
      ln -s $srcPath $fullPath;
    fi;
  fi;
done;
ending 'symlinking of dotfiles'

if [[ ! -a ~/.config/nvim/autoload/plug.vim ]]; then;
  # Vim-Plug Install
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  nvim +PlugInstall
fi;

cd $OLDDIR
