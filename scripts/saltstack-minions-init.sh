#!/bin/bash

##################################
## SALTSTACK MINION INIT SCRIPT
##
## BECAUSE NOBODY LIKES CLOUD-INIT
##################################

if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    exit 
fi

# Update system
apt-get update
apt-get upgrade -y
apt-get autoremove -y

# Add salt repos to system
sudo curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/debian/11/amd64/latest/salt-archive-keyring.gpg
echo 'deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/py3/debian/11/amd64/latest bullseye main' | sudo tee /etc/apt/sources.list.d/salt.list

# Install salt
apt-get update
apt-get install salt-minion -y

# Activate Salt
systemctl start salt-minion
