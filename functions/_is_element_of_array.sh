#!/usr/bin/env bash

function _is_element_of_array {
  local array=("${!1}")  # Use indirect reference to get the array
  local search_string="$2"

  # Iterate through the array and check for a match
  for element in "${array[@]}"; do
    if [ "$element" == "$search_string" ]; then
      return 0  # Match found
    fi
  done

  return 1  # No match found
}

# Export function to be used by child scripts
export -f _is_element_of_array

