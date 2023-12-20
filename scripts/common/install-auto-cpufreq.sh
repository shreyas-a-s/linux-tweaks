#!/bin/sh

if ! find /sys/class/power_supply -mindepth 1 -maxdepth 1 | read; then
  printf "\n${BRED}This does't seem like a laptop,${NC} hence not installing auto-cpufreq\n\n" 2>&1
  exit 1
fi

# Install auto-cpufreq - For better battery life on laptops
cd ../../.. || exit
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq || exit
sudo ./auto-cpufreq-installer
sudo auto-cpufreq --install

# Set auto-cpufreq config for i3-115G4
if [ "$(lscpu | sed -nr '/Model name/ s/.*:\s*(.*) @ .*/\1/p' | awk -F '-' '{print $NF}')" = "1115G4" ]; then
  printf "[charger]\
  \ngovernor = performance\
  \nturbo = auto\

  \n[battery]\
  \ngovernor = powersave\
  \nscaling_min_freq = 400000\
  \nscaling_max_freq = 1700000\
  \nturbo = never" | sudo tee /etc/auto-cpufreq.conf > /dev/null
else
  printf "[charger]\
  \ngovernor = performance\
  \nturbo = auto\

  \n[battery]\
  \ngovernor = powersave\
  \nturbo = never" | sudo tee /etc/auto-cpufreq.conf > /dev/null
fi

