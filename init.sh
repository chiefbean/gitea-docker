#!/bin/sh

sudo mkdir /dev/net
sudo mknod /dev/net/tun c 10 200
sudo ip tuntap add mode tap tap

cd /home/git && sudo openvpn --config BEAN-GIT.ovpn --daemon

/usr/local/bin/gitea
