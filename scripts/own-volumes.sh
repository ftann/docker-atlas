#!/usr/bin/env bash

. ./scripts/util/var.sh
. ./scripts/util/volume.sh

PUID=$(get_uid)
PGID=$(get_gid)

own_volume volumes/airsonic "$PUID" "$PGID"
own_volume volumes/airsonic_db "$PUID" "$PGID"
own_volume volumes/nginx "$PUID" "$PGID"
own_volume volumes/ldap "$PUID" "$PGID"
own_volume volumes/plex "$PUID" "$PGID"
own_volume volumes/nextcloud "$PUID" "$PGID"
own_volume volumes/nextcloud_db "$PUID" "$PGID"
own_volume volumes/restic_data "$PUID" "$PGID"
own_volume volumes/restic_volumes "$PUID" "$PGID"
own_volume volumes/syncthing "$PUID" "$PGID"
own_volume volumes/teamspeak "$PUID" "$PGID"
own_volume volumes/teamspeak_db "$PUID" "$PGID"
