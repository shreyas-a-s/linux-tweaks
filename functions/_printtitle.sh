#!/bin/sh

# Variables
function _define_variables {

  number_of_columns="$(tput cols)"
  title="$*"
  length_of_title="$(expr length "$title")"
  left_padding="$(((($number_of_columns - $length_of_title)) / 2))"

}

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

  _define_variables "$@"

  _draw_the_line

  _add_left_padding

  printf "$title"

  _draw_the_line

  printf "\n"

}

