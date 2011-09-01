#!/usr/bin/env bash

echo "--------------------------"
echo "   Installing dotfiles!"
echo "--------------------------"

files='.vimrc .bashrc'

for file in $files;
do
  echo "Linking $PWD/$file to ~/$file"
  ln -s $PWD/$file ~/ 2>/dev/null
  success=$?
  if [[ $success -eq 0 ]];
  then
    echo "Link made successfully."
  else
    echo "Shall I remove the existing $file?"
    read remove
    if [[ $remove == "Y" || $remove == "y" ]];
    then
      echo "removing the existing file."
      rm ~/$file
      echo "Linking again."
      ln -s $PWD/$file ~/ 2>/dev/null
      success=$?
      if [[ ! $success -eq 0 ]];
      then
        echo "Link made successfully."
      fi
    fi
  fi
  echo
done

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
