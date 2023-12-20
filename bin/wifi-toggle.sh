#!/bin/sh

if nmcli radio wifi | grep -q disabled; then
  nmcli radio wifi on
else
  nmcli radio wifi off
fi
