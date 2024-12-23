#!/bin/sh

# To be run on a new machine, serves as knowledge store for everything
# inappropriate for storage in another format.

echo "https://cdn.openbsd.org/pub/OpenBSD/" > /etc/installurl

export PKG_PATH=https://cdn.openbsd.org/%m
pkg_add zsh python nut git vim tailscale

# for unifi
pkg_add unzip mongodb jdk javaPathHelper

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

cd /tmp
ftp https://cdn.openbsd.org/pub/OpenBSD/$(uname -r)/{ports.tar.gz,SHA256.sig}
signify -Cp /etc/signify/openbsd-$(uname -r | cut -c 1,3)-base.pub -x SHA256.sig ports.tar.gz

cd /usr
tar xzf /tmp/ports.tar.gz

cd /usr/ports/net/unifi/main
make install

rcctl enable unifi

echo "Don't forget to login and run: "
echo "   doas tailscale up --advertise-exit-node --advertise-routes=192.168.8.0/24 --accept-routes --ssh --accept-dns=false"
