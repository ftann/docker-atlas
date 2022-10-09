#!/usr/bin/env sh

cp -uR /defaults/* /config
chown "${PUID}:${PGID}" -R /config
