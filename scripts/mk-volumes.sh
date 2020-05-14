#!/usr/bin/env bash

. ./scripts/util/volume.sh

create_volume volumes/ldap
create_volume volumes/nginx
create_volume volumes/nextcloud
create_volume volumes/nextcloud_db
create_volume volumes/plex
create_volume volumes/restic_data
create_volume volumes/restic_volumes
create_volume volumes/syncthing
create_volume volumes/teamspeak
create_volume volumes/teamspeak_db
