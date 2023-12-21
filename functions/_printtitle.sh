#!/bin/sh

function _printtitle {
  
  echo

  for i in $(seq "$(tput cols)"); do
    printf '-'
  done
  echo

  for i in $(seq $((($(tput cols) - $(expr length "$@")) / 2))); do
    printf ' '
  done
  
  printf "$@\n"

  for i in $(seq "$(tput cols)"); do
    printf '-'
  done
  echo 
}

