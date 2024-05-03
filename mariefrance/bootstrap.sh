#!/bin/sh

# To be run on a new machine, serves as knowledge store for everything
# inappropriate for storage in another format.

echo "https://cdn.openbsd.org/pub/OpenBSD/" > /etc/installurl

export PKG_PATH=https://cdn.openbsd.org/%m
pkg_add zsh
pkg_add python
pkg_add nut
pkg_add git
pkg_add vim
pkg_add tailscale

rcctl set syslogd flags "-U 127.0.0.1"
rcctl restart syslogd
rcctl enable dhcpd
rcctl set dhcpd flags "-A dhcpd_abandoned -L dhcpd_leased"
rcctl enable httpd
rcctl set pflogd flags "-s 1500"
rcctl disable resolvd
rcctl stop resolvd
rcctl enable unbound
rcctl set ntpd flags -s
rcctl enable upsmon

rcctl enable tailscaled

echo "Don't forget to login and run: "
echo "   doas tailscale up --advertise-exit-node --advertise-routes=192.168.8.0/24 --accept-routes --ssh --accept-dns=false"
