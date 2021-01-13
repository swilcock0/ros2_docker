#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install some common tools for further installation"
apt-get update 
apt-get install -y wget net-tools locales bzip2
apt-get clean -y
rm -rf /var/lib/apt/lists/*

echo "generate locales for en_US.UTF-8"
locale-gen en_US.UTF-8