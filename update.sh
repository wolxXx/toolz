#!/bin/bash
clear;
echo "wolxXxShellTools: script for updating apt-sources and upgrade and dist-upgrade and clean ups";
echo "..updating";
sudo rm -rf /var/lib/apt/lists
sudo apt update;
sudo apt list --upgradable
sudo apt dist-upgrade -y;
sudo apt autoclean -y;
sudo apt autoremove -y;
sudo apt autoclean -y;
sudo apt clean;
echo "..done. bye bye!";
exit 0;
