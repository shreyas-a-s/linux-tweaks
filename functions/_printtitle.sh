#!/usr/bin/env bash

# Sub function 1
function _draw_the_line {

  printf "\n"

  for i in $(seq $number_of_columns); do
    printf '-'
  done

}

# Sub function 2
function _add_left_padding {

  printf "\n"

  for i in $(seq $left_padding); do
    printf ' '
  done

}

# Actual function
function _printtitle {

  # Define Variables
  number_of_columns="$(tput cols)"
  title="$*"
  length_of_title="$(expr length "$title")"
  left_padding="$(((($number_of_columns - $length_of_title)) / 2))"


  _draw_the_line

  _add_left_padding

  printf "$title"

  _draw_the_line

  printf "\n"

}

export -f _draw_the_line
export -f _add_left_padding
export -f _printttle

