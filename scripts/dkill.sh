#!/bin/bash
ps aux | awk 'NR!=1 {print "Process: "$11}'  | dmenu -i -p "Search for the process to kill:" -sb "#1D7C3A" -sf "#FFFFFF" | awk '{print $2}' | xargs pkill -f
