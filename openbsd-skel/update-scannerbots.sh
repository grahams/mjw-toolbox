#!/bin/sh
# TODO: fix all these to support weird usernames and ipv6
< /var/log/authlog \
  grep 'sshd.*Invalid user'|sed -es'%^.* from%%g' -es'% port.*$%%g' |\
  xargs doas pfctl -t scannerbots -T add
doas zcat /var/log/authlog.* | \
  grep 'sshd.*Invalid user'|sed -es'%^.* from%%g' -es'% port.*$%%g' |\
  xargs doas pfctl -t scannerbots -T add
< /var/log/authlog \
  awk '/Disconnected from invalid user/ {print $11}'| \
  sort -n|uniq|grep -v '[[:alpha:]]'|xargs doas pfctl -t scannerbots -T add
doas zcat /var/log/authlog.* | \
  awk '/Disconnected from invalid user/ {print $11}'| \
  sort -n|uniq|grep -v '[[:alpha:]]'|xargs doas pfctl -t scannerbots -T add
< /var/log/authlog \
  awk '/Disconnected from authenticating user/ {print $11}'| \
  sort -n|uniq|grep -v '[[:alpha:]]'|xargs doas pfctl -t scannerbots -T add
doas zcat /var/log/authlog.* | \
  awk '/Disconnected from authenticating user/ {print $11}'| \
  sort -n|uniq|grep -v '[[:alpha:]]'|xargs doas pfctl -t scannerbots -T add
< /var/log/authlog \
  awk '/Unable to negotiate/ {print $10}'| \
  sort -n|uniq|grep -v '[[:alpha:]]'|xargs doas pfctl -t scannerbots -T add
doas zcat /var/log/authlog.* | \
  awk '/Unable to negotiate/ {print $10}'| \
  sort -n|uniq|grep -v '[[:alpha:]]'|xargs doas pfctl -t scannerbots -T add
# Optional $1: path to the blessed nodes file (default ../pf.blessed_nodes,
# relative to the current directory).
doas pfctl -t scannerbots -T delete -f "${1:-../pf.blessed_nodes}"
T=$(mktemp) && doas pfctl -t scannerbots -T show > "$T" && \
  doas mv "$T" /etc/pf.scannerbots
