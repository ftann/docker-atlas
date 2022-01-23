#!/usr/bin/env bash

. ./scripts/util/pw.sh
. ./scripts/util/secret.sh
. ./scripts/util/var.sh

#
# Generated secrets.
#
create_secret secrets/authelia_db "$(rnd_pw 20)"
create_secret secrets/authelia_jwt "$(rnd_pw 20)"
create_secret secrets/authelia_session "$(rnd_pw 20)"
create_secret secrets/ldap_auth "$(rnd_pw 20)"
create_secret secrets/ldap_db "$(rnd_pw 20)"
create_secret secrets/nextcloud_db "$(rnd_pw 20)"
create_secret secrets/restic_data "$(rnd_pw 20)"
create_secret secrets/restic_volumes "$(rnd_pw 20)"
create_secret secrets/teamspeak_db "$(rnd_pw 20)"

#
# Predefined secrets.
#
create_secret secrets/backblaze_id "$(get_b2_id)"
create_secret secrets/backblaze_key "$(get_b2_key)"

create_secret secrets/cloudflare "$(cat <<-EOF
dns_cloudflare_api_token=$(get_cloudflare_token)
EOF
)"

create_secret secrets/inadyn "$(cat <<-EOF
username=$(get_domain)
password=$(get_cloudflare_token)
hostname={$(get_domain)}
EOF
)"

create_secret secrets/maxmind "$(get_maxmind_key)"
