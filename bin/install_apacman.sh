#!/bin/sh
TMP_DIR=/tmp/packer

rm -rf $TMP_DIR
mkdir -p $TMP_DIR
cd $TMP_DIR

curl -o PKGBUILD "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=apacman"
makepkg -sri
