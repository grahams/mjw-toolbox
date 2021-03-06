#!/bin/sh

# To be run on a new machine, serves as knowledge store for everything
# inappropriate for storage in another format.

echo "https://cdn.openbsd.org/pub/OpenBSD/" > /etc/installurl

export PKG_PATH=https://cdn.openbsd.org/%m
pkg_add git
pkg_add vim
pkg_add pfstat
pkg_add munin-server
pkg_add p5-Net-SNMP

rcctl set syslogd flags "-U 127.0.0.1"
rcctl restart syslogd
rcctl enable dhcpd
rcctl enable httpd
rcctl set pflogd flags "-s 1500"
rcctl enable unbound
rcctl set ntpd flags -s

rcctl enable munin_node

mkdir -p /var/www/htdocs/pf

usermod -G _munin www

echo "For pfstat stats and graphs, add pfstat -qp to root's crontab."
