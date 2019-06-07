#!/usr/bin/env bash

# Exit script as soon as a command fails.
set -o errexit

if [[ "$(id -u)" != "0" ]]; then
   echo "This script must be run as superuser"
   exit 1
fi

github_url='https://raw.githubusercontent.com/avsigaev/hive-xconfig'

if ! [[ -z $1 ]]; then
	branch=$1
else
	branch='master'
fi

wget -q ${github_url}/${branch}/sonm-xorg-config.service -O /etc/systemd/system/sonm-xorg-config.service
wget -q ${github_url}/${branch}/sonm-xorg-config -O /usr/bin/sonm-xorg-config

chmod +x /usr/bin/sonm-xorg-config

echo Enabling service
systemctl daemon-reload
systemctl enable sonm-xorg-config.service
systemctl restart sonm-xorg-config.service

echo Done
