#!/usr/bin/env bash

# passing "real" as first argument makes the script do the thing.
mode=$1

target_home="$HOME"
echo "HOME is $target_home"

do_if_real() {
  cmd=$@
  if [ "$mode" = "real" ];
  then
    echo "Running: $cmd"
    $cmd
  else
    echo "Would have run: $cmd"
  fi
}

install_dotfile() {
  dotfile=$1
  dotfile_relative=$( echo $dotfile | sed "s|^home.||" )
  target_location="$target_home/$dotfile_relative"
  target_path=$( dirname $target_location );
  do_if_real mkdir -p $target_path
  do_if_real ln -s `pwd`/$dotfile $target_location
}

install_alias() {
  dotfile=$1
  target_alias=$2
  curdir=$( pwd )
  do_if_real ln -s "$curdir/home/$dotfile" "$target_home/$target_alias"
}

install_aliases() {
  install_alias ".bashrc" ".profile"
}

install_bin() {
  curdir=$( pwd )
  do_if_real mkdir -p $target_home/bin
  for f in $( find bin -type f );
  do
    do_if_real ln -s "$curdir"/$f $target_home/$f
  done
}

main() {
  for dotfile in $( find home -type f );
  do
    install_dotfile $dotfile 
  done
  install_aliases
  install_bin
}

main
