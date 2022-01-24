#!/usr/bin/env bash

. ./scripts/util/var.sh
. ./scripts/util/volume.sh

PUID=$(get_uid)
PGID=$(get_gid)

own_volume volumes/authelia "$PUID" "$PGID"
own_volume volumes/authelia_db "$PUID" "$PGID"
own_volume volumes/inadyn "$PUID" "$PGID"
own_volume volumes/ldap "$PUID" "$PGID"
own_volume volumes/nextcloud "$PUID" "$PGID"
own_volume volumes/nextcloud_db "$PUID" "$PGID"
own_volume volumes/plex "$PUID" "$PGID"
own_volume volumes/protonmail-bridge "$PUID" "$PGID"
own_volume volumes/restic "$PUID" "$PGID"
own_volume volumes/swag "$PUID" "$PGID"
own_volume volumes/syncthing "$PUID" "$PGID"
own_volume volumes/teamspeak "$PUID" "$PGID"
own_volume volumes/teamspeak_db "$PUID" "$PGID"
