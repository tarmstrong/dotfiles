#!/usr/bin/env bash

echo "--------------------------"
echo "   Installing dotfiles!"
echo "--------------------------"

files='.vimrc .bashrc'

for file in $files;
do
  echo "Linking $file to ~/$file"
  ln -s $PWD/$file ~/ 2>/dev/null
  success=$?
  [[ $success -eq 0 ]] || echo "Link already exists"
  echo
done
