#!/usr/bin/env bash

# Define Variables
number_of_columns="$(tput cols)"
left_padding_fancy="$(((($number_of_columns - 92)) / 2))"
left_padding_simple="$(((($number_of_columns - 53)) / 2))"
left_padding_thats_left="$(((($number_of_columns - 14)) / 2))"

# Sub function 1
function _draw_the_line {

  printf "\n"

  for i in $(seq $number_of_columns); do
    printf '-'
  done

}

# Sub function 2
function _add_left_padding_fancy {

  printf "\n"

  for i in $(seq $left_padding_fancy); do
    printf ' '
  done

}

# Sub function 3
function _add_left_padding_simple {

  printf "\n"

  for i in $(seq $left_padding_simple); do
    printf ' '
  done

}

# Sub function 4
function _add_left_padding_thats_left {

  printf "\n"

  for i in $(seq $left_padding_thats_left); do
    printf ' '
  done

}

# Actual function 1
function _print_fancy_main_title {

  _draw_the_line
  _add_left_padding_fancy

  printf "██╗     ██╗███╗   ██╗██╗   ██╗██╗  ██╗  ████████╗██╗    ██╗███████╗ █████╗ ██╗  ██╗███████╗"
  _add_left_padding_fancy
  printf "██║     ██║████╗  ██║██║   ██║╚██╗██╔╝  ╚══██╔══╝██║    ██║██╔════╝██╔══██╗██║ ██╔╝██╔════╝"
  _add_left_padding_fancy
  printf "██║     ██║██╔██╗ ██║██║   ██║ ╚███╔╝█████╗██║   ██║ █╗ ██║█████╗  ███████║█████╔╝ ███████╗"
  _add_left_padding_fancy
  printf "██║     ██║██║╚██╗██║██║   ██║ ██╔██╗╚════╝██║   ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ ╚════██║"
  _add_left_padding_fancy
  printf "███████╗██║██║ ╚████║╚██████╔╝██╔╝ ██╗     ██║   ╚███╔███╔╝███████╗██║  ██║██║  ██╗███████║"
  _add_left_padding_fancy
  printf "╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝     ╚═╝    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝"

  _draw_the_line

  printf "\n"

}

# Actual function 2
function _print_simple_main_title {

  _draw_the_line
  _add_left_padding_simple
  printf '|    | |  | |  |\   /   ___ |  |  ___      |   / __'
  _add_left_padding_simple
  printf '|    | |\ | |  | \_/ __  |  |  | |__   /\  |__/ /__`'
  _add_left_padding_simple
  printf '|___ | | \| \__/ / \     |  |/\| |___ /~~\ |  \ .__/'

  _draw_the_line

  printf "\n"

}

# Actual function 3
function _print_the_main_title_thats_left {

  _draw_the_line

  _add_left_padding_thats_left

  printf "LINUX - TWEAKS"

  _draw_the_line

}

# Actual execution
if [ "$number_of_columns" -ge 92 ]; then
  _print_fancy_main_title
elif [ "$number_of_columns" -ge 53 ]; then
  _print_simple_main_title
else
  _print_the_main_title_thats_left
fi

