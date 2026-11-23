blueant: \
	/etc/acme-client.conf \
	/etc/beszel_agent.env \
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
	/etc/hostname.sec0 \
	/etc/hostname.vlan13 \
	/etc/hostname.vlan666 \
	/etc/httpd.conf \
	/etc/iked.conf \
	/etc/mygate \
	/etc/login.conf \
	/etc/mail/smtpd.conf \
	/etc/mail/secrets \
	/etc/newsyslog.conf \
	/etc/ntpd.conf \
	/etc/pf.conf \
	/etc/rad.conf \
	/etc/rc.conf.local \
	/etc/resolv.conf \
	/etc/sensorsd.conf \
	/etc/shells \
	/etc/smokeping/config \
	/etc/ssh/ssh_config \
	/etc/ssh/sshd_config \
	/etc/sysctl.conf \
	/etc/syslog.conf \
	/etc/ttys \
	/etc/rc.d/beszel_agent \
	/var/log/unbound \
	/var/unbound/etc/unbound.conf \
	.installed.shutdown-low-battery.sh \
	.installed.forward \
	/etc/pf.blessed_nodes \
	/usr/local/sbin/update-scannerbots.sh

# Targets for configs with a syntax checker run it before installing, so
# a typo fails the make instead of breaking the service on next start.

/etc/acme-client.conf : acme-client.conf
	doas acme-client -n -f acme-client.conf > /dev/null
	doas install -o root -g wheel -m 0644 \
	  acme-client.conf /etc/acme-client.conf

/etc/beszel_agent.env: beszel_agent.env
	op run --env-file=.env -- \
	  sh ../install-secretfied.sh \
	    beszel_agent.env \
	    "-o root -g wheel -m 0600" \
	    /etc/beszel_agent.env

/etc/rc.d/beszel_agent : beszel_agent
	doas install -o root -g wheel -m 0755 \
	  beszel_agent /etc/rc.d/beszel_agent

/etc/boot.conf : boot.conf
	doas install -o root -g wheel -m 0644 \
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
	doas dhcpd -n -c dhcpd.conf
	doas install -o root -g wheel -m 0644 \
	  dhcpd.conf /etc/dhcpd.conf

/etc/doas.conf : doas.conf
	doas -C doas.conf
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

/etc/hostname.sec0 : hostname.sec0
	doas install -o root -g wheel -m 0640 \
	  hostname.sec0 /etc/hostname.sec0

/etc/hostname.vlan13 : hostname.vlan13
	doas install -o root -g wheel -m 0640 \
	  hostname.vlan13 /etc/hostname.vlan13

/etc/hostname.vlan666 : hostname.vlan666
	doas install -o root -g wheel -m 0640 \
	  hostname.vlan666 /etc/hostname.vlan666

/etc/httpd.conf : httpd.conf
	doas httpd -n -f httpd.conf
	doas install -o root -g wheel -m 0644 \
	  httpd.conf /etc/httpd.conf

# iked insists on a root-owned 0600 file, so check after installing
/etc/iked.conf : iked.conf
	op run --env-file=.env -- \
	  sh ../install-secretfied.sh \
	    iked.conf \
	    "-o root -g wheel -m 0600" \
	    /etc/iked.conf
	doas iked -n -f /etc/iked.conf

/etc/mygate : mygate
	doas install -o root -g wheel -m 0644 \
	  mygate /etc/mygate

/etc/login.conf : login.conf
	doas install -o root -g wheel -m 0644 \
	  login.conf /etc/login.conf

/etc/mail/smtpd.conf : smtpd.conf
	doas smtpd -n -f smtpd.conf
	doas install -o root -g wheel -m 0644 \
	  smtpd.conf /etc/mail/smtpd.conf

/etc/mail/secrets : smtp-secrets
	op run --env-file=.env -- \
	  sh ../install-secretfied.sh \
	  smtp-secrets \
	  "-o root -g _smtpd -m 0640" \
	  /etc/mail/secrets

/etc/newsyslog.conf : newsyslog.conf
	doas install -o root -g wheel -m 0644 \
	  newsyslog.conf /etc/newsyslog.conf

/etc/ntpd.conf : ntpd.conf
	doas ntpd -n -f ntpd.conf
	doas install -o root -g wheel -m 0644 \
	  ntpd.conf /etc/ntpd.conf

/etc/pf.conf : pf.conf
	doas pfctl -nf pf.conf
	doas install -o root -g wheel -m 0600 \
	  pf.conf /etc/pf.conf

/etc/pf.blessed_nodes : pf.blessed_nodes
	doas install -o root -g wheel -m 0644 \
	  pf.blessed_nodes /etc/pf.blessed_nodes

/etc/rad.conf : rad.conf
	doas rad -n -f rad.conf
	doas install -o root -g wheel -m 0644 \
	  rad.conf /etc/rad.conf

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
	doas sshd -t -f ../openbsd-skel/sshd_config
	doas install -o root -g wheel -m 0644 \
	  ../openbsd-skel/sshd_config /etc/ssh/sshd_config

/etc/sysctl.conf : sysctl.conf
	doas install -o root -g wheel -m 0644 \
	  sysctl.conf /etc/sysctl.conf

/etc/syslog.conf : syslog.conf
	doas install -o root -g wheel -m 0644 \
	  syslog.conf /etc/syslog.conf

/etc/ttys : ttys
	doas install -o root -g wheel -m 0644 \
	  ttys /etc/ttys

/var/log/unbound :
	doas touch /var/log/unbound
	doas chown root:_unbound /var/log/unbound
	doas chmod 644 /var/log/unbound

# install beside the live config and check it there, inside the chroot
/var/unbound/etc/unbound.conf : unbound.conf
	doas install -o root -g _unbound -m 0640 \
	  unbound.conf /var/unbound/etc/unbound.conf.new
	doas unbound-checkconf /var/unbound/etc/unbound.conf.new
	doas mv /var/unbound/etc/unbound.conf.new /var/unbound/etc/unbound.conf

# make can't see into /root (mode 700) as a normal user, so these two
# track a stamp file here instead of the installed file.
.installed.shutdown-low-battery.sh : shutdown-low-battery.sh
	doas install -D -o root -g wheel -m 0700 \
	  shutdown-low-battery.sh /root/bin/shutdown-low-battery.sh
	touch $@

.installed.forward : .forward
	doas install -o root -g wheel -m 0644 \
	  .forward /root/.forward
	touch $@

/usr/local/sbin/update-scannerbots.sh : ../openbsd-skel/update-scannerbots.sh
	doas install -o root -g wheel -m 0755 \
	  ../openbsd-skel/update-scannerbots.sh /usr/local/sbin/update-scannerbots.sh
