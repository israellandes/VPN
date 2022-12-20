#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y openvpn
sudo rm ~/openvpn-install.sh*
cd ~ && wget https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
sudo chmod +x ~/openvpn-install.sh
cd ~ && export AUTO_INSTALL=y &&\

if export AUTO_INSTALL=y && sudo ~/openvpn-install.sh ; then
    echo "Command succeeded"
else
    echo "Command failed"
    echo "Building TUN"
    sudo rm -dr /dev/net
    if [ -d "/dev/net/tun" ] ; then
        echo "Directory /dev/net/tun exists, exiting"
	exit 1
    else
        echo "Directory /dev/net/tun does not exist, building TUN dir."
        sudo mkdir /dev/net && cd /dev && sudo mknod net/tun c 10 200 && sudo chmod 0666 /dev/net/tun
        cd ~ && export AUTO_INSTALL=y && sudo ~/openvpn-install.sh
        exit 0
    fi
fi
