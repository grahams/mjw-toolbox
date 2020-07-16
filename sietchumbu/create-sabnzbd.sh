#!/bin/sh
CONTAINER=linuxserver/sabnzbd
docker stop sabnzbd
docker rm sabnzbd
docker pull ${CONTAINER}
docker run \
  -d \
  --name sabnzbd \
  --restart always \
  -e PUID="501" \
  -e PGID="100" \
  -p 8080:8080 \
  -v /home/multi/sabnzbd-config:/config \
  -v /home/multi/inbound/incomplete:/incomplete-downloads \
  -v /home/multi/inbound/complete:/downloads \
  -v /home/multi:/multi \
  ${CONTAINER}
docker system prune