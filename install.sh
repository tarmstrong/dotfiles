#!/usr/bin/env bash

echo "--------------------------"
echo "   Installing dotfiles!"
echo "--------------------------"

files='.vimrc .bashrc'

for file in $files;
do
  echo "Linking $PWD/$file to /home/tavish/$file"
  rm /home/tavish/$file
  ln -s $PWD/$file /home/tavish/
  echo
done

if [[ -d /home/tavish/.vim ]];
then
  rm -r /home/tavish/.vim
fi

ln -s $PWD/.vim /home/tavish/

if [[ ! -d  /home/tavish/.vim/tmp/swap ]];
then
  echo "Making .vim swap directory."
  mkdir -p /home/tavish/.vim/tmp/swap
fi

if [[ ! -d  /home/tavish/.vim/tmp/backup ]];
then
  echo "Making .vim backup directory"
  mkdir -p /home/tavish/.vim/tmp/backup
fi

echo 'You will have to copy the .gitconfig yourself.'

if [ ! -d /home/tavish/bin/$f ];
then
  mkdir /home/tavish/bin
fi

echo "Copying the bin scripts."
for f in $( ls $PWD/bin );
do
  if [ -f /home/tavish/bin/$f ];
  then
    rm /home/tavish/bin/$f
  fi
  ln -s $PWD/bin/$f /home/tavish/bin/$f
done
