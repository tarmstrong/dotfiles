#!/usr/bin/env bash

echo "--------------------------"
echo "   Installing dotfiles!"
echo "--------------------------"

files='.vimrc .bashrc'

for file in $files;
do
  echo "Linking $PWD/$file to ~/$file"
  rm ~/$file
  ln -s $PWD/$file ~/
  echo
done

if [[ -d ~/.vim ]];
then
  rm -r ~/.vim
fi

ln -s $PWD/.vim ~/

if [[ ! -d  ~/.vim/tmp/swap ]];
then
  echo "Making .vim swap directory."
  mkdir -p ~/.vim/tmp/swap
fi

if [[ ! -d  ~/.vim/tmp/backup ]];
then
  echo "Making .vim backup directory"
  mkdir -p ~/.vim/tmp/backup
fi

echo 'You will have to copy the .gitconfig yourself.'

if [ ! -d ~/bin/$f ];
then
  mkdir ~/bin
fi

echo "Copying the bin scripts."
for f in $( ls $PWD/bin );
do
  if [ -f ~/bin/$f ];
  then
    rm ~/bin/$f
  fi
  ln -s $PWD/bin/$f ~/bin/$f
done
