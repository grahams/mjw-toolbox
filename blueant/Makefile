blueant: \
	/etc/acme-client.conf \
	/etc/boot.conf \
	/etc/avahi/avahi-daemon.conf \
	/etc/daily.local \
	/etc/dhclient.conf \
	/etc/dhcpd.conf \
	/etc/doas.conf \
	/etc/hostname.ix0 \
	/etc/hostname.ix1 \
	/etc/hostname.enc0 \
	/etc/hostname.enc1 \
	/etc/hostname.vlan13 \
	/etc/hostname.vlan666 \
	/etc/httpd.conf \
	/etc/iked.conf \
	/etc/mygate \
	/etc/login.conf \
	/etc/newsyslog.conf \
	/etc/ntpd.conf \
	/etc/pf.conf \
	/etc/pf.sshbots \
	/etc/rc.conf.local \
	/etc/resolv.conf \
	/etc/sensorsd.conf \
	/etc/shells \
	/etc/smokeping/config \
	/etc/ssh/ssh_config \
	/etc/ssh/sshd_config \
	/etc/sysctl.conf \
	/etc/syslog.conf \
	/etc/telegraf/telegraf.conf \
	/etc/ttys \
	/var/log/unbound \
	/var/unbound/etc/unbound.conf \
	/root/bin/shutdown-low-battery.sh \
	/root/.forward

/etc/acme-client.conf : acme-client.conf
	doas install -o root -g wheel -m 0644 \
	  acme-client.conf /etc/acme-client.conf

/etc/boot.conf : boot.conf
	install -o root -g wheel -m 0644 \
	  boot.conf /etc/boot.conf

/etc/avahi/avahi-daemon.conf : avahi-daemon.conf
	@if ! [ -d /var/db/pkg/avahi-libs* ]; then doas pkg_add avahi; fi
	doas install -o root -g wheel -m 0644 \
	  avahi-daemon.conf /etc/avahi/avahi-daemon.conf

/etc/daily.local : daily.local
	doas install -o root -g wheel -m 0644 \
	  daily.local /etc/daily.local

/etc/dhclient.conf : dhclient.conf
	doas install -o root -g wheel -m 0644 \
	  dhclient.conf /etc/dhclient.conf

/etc/dhcpd.conf : dhcpd.conf
	doas install -o root -g wheel -m 0644 \
	  dhcpd.conf /etc/dhcpd.conf

/etc/doas.conf : doas.conf
	doas install -o root -g wheel -m 0600 \
	  doas.conf /etc/doas.conf

/etc/hostname.ix0 : hostname.ix0
	doas install -o root -g wheel -m 0640 \
	  hostname.ix0 /etc/hostname.ix0

/etc/hostname.ix1 : hostname.ix1
	doas install -o root -g wheel -m 0640 \
	  hostname.ix1 /etc/hostname.ix1

/etc/hostname.enc0 : hostname.enc0
	doas install -o root -g wheel -m 0640 \
	  hostname.enc0 /etc/hostname.enc0

/etc/hostname.enc1 : hostname.enc1
	doas install -o root -g wheel -m 0640 \
	  hostname.enc1 /etc/hostname.enc1

/etc/hostname.vlan13 : hostname.vlan13
	doas install -o root -g wheel -m 0640 \
	  hostname.vlan13 /etc/hostname.vlan13

/etc/hostname.vlan666 : hostname.vlan666
	doas install -o root -g wheel -m 0640 \
	  hostname.vlan666 /etc/hostname.vlan666

/etc/httpd.conf : httpd.conf
	doas install -o root -g wheel -m 0644 \
	  httpd.conf /etc/httpd.conf

/etc/iked.conf : iked.conf
	op run --env-file=.env -- \
	  sh ../install-secretfied.sh \
	    iked.conf \
	    "-o root -g wheel -m 0600" \
	    /etc/iked.conf

/etc/mygate : mygate
	doas install -o root -g wheel -m 0644 \
	  mygate /etc/mygate

/etc/login.conf : login.conf
	doas install -o root -g wheel -m 0644 \
	  login.conf /etc/login.conf

/etc/newsyslog.conf : newsyslog.conf
	doas install -o root -g wheel -m 0644 \
	  newsyslog.conf /etc/newsyslog.conf

/etc/ntpd.conf : ntpd.conf
	doas install -o root -g wheel -m 0644 \
	  ntpd.conf /etc/ntpd.conf

/etc/pf.conf : pf.conf 
	doas install -o root -g wheel -m 0600 \
	  pf.conf /etc/pf.conf

/etc/pf.sshbots: ../openbsd-skel/pf.sshbots
	doas install -o root -g wheel -m 0600 \
	  ../openbsd-skel/pf.sshbots /etc/pf.sshbots

/etc/rc.conf.local : rc.conf.local
	doas install -o root -g wheel -m 0644 \
	  rc.conf.local /etc/rc.conf.local

/etc/resolv.conf : resolv.conf
	doas install -o root -g wheel -m 0644 \
	  resolv.conf /etc/resolv.conf

/etc/sensorsd.conf : sensorsd.conf
	doas install -o root -g wheel -m 0644 \
	  sensorsd.conf /etc/sensorsd.conf

/etc/shells : shells
	doas install -o root -g wheel -m 0644 \
	  shells /etc/shells

/etc/smokeping/config : smokeping-config
	@if ! [ -d /etc/smokeping ]; then doas pkg_add smokeping; fi
	doas install -o root -g wheel -m 0644 \
	  smokeping-config /etc/smokeping/config
	@if ! rcctl ls on | grep smokeping > /dev/null; then doas rcctl enable smokeping; fi
	@if ! rcctl ls started | grep smokeping > /dev/null; then doas rcctl start smokeping; fi
	@if ! rcctl ls on | grep smokeping_fcgi > /dev/null; then doas rcctl enable smokeping_fcgi; fi
	@if ! rcctl ls started | grep smokeping_fcgi > /dev/null; then doas rcctl start smokeping_fcgi; fi

/etc/ssh/ssh_config : ssh_config
	doas install -o root -g wheel -m 0644 \
	  ssh_config /etc/ssh/ssh_config

/etc/ssh/sshd_config : ../openbsd-skel/sshd_config
	doas install -o root -g wheel -m 0644 \
	  ../openbsd-skel/sshd_config /etc/ssh/sshd_config

/etc/sysctl.conf : sysctl.conf
	doas install -o root -g wheel -m 0644 \
	  sysctl.conf /etc/sysctl.conf

/etc/syslog.conf : syslog.conf
	doas install -o root -g wheel -m 0644 \
	  syslog.conf /etc/syslog.conf

/etc/telegraf/telegraf.conf : telegraf.conf
	@if ! [ -d /var/db/pkg/telegraf* ]; then doas pkg_add telegraf; fi
	~/bin/op run --env-file=.env -- \
	  sh ../install-secretfied.sh \
	    telegraf.conf \
	    "-o root -g wheel -m 0644" \
	    /etc/telegraf/telegraf.conf

/etc/ttys : ttys
	install -o root -g wheel -m 0644 \
	  ttys /etc/ttys

/var/log/unbound :
	doas touch /var/log/unbound
	doas chown root:_unbound /var/log/unbound
	doas chmod 644 /var/log/unbound

/var/unbound/etc/unbound.conf : unbound.conf
	doas install -o root -g _unbound -m 0640 \
	  unbound.conf /var/unbound/etc/unbound.conf

/root/bin/shutdown-low-battery.sh : shutdown-low-battery.sh
	doas install -D -o root -g wheel -m 0700 \
	  shutdown-low-battery.sh /root/bin/shutdown-low-battery.sh

/root/.forward : .forward
	doas install -o root -g wheel -m 0644 \
	  .forward /root/.forward
