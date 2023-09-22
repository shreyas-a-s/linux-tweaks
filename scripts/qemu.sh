#!/bin/bash
read -r -p "Continue to install qemu and virt-manager? (yes/no): " qemu_choice
case "$qemu_choice" in 
    "yes" ) echo "Starting the installation.."; (cd .. && git clone https://github.com/shreyas-a-s/debian-qemu.git && cd debian-qemu/ && ./install.sh);;
    "no" ) exit 1;;
    * ) echo "Invalid Choice! Keep in mind this is CASE-SENSITIVE."; choiceOfQemu;;
esac