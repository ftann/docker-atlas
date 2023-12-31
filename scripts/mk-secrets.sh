#!/usr/bin/env bash

. ./scripts/inc.sh

#
# Generated secrets.
#
create_secret secrets/authelia_db "$(rnd_pw 20)"
create_secret secrets/authelia_identity_hmac "$(rnd_pw 32)"
create_secret secrets/authelia_identity_key "$(gen_private_key)"
create_secret secrets/authelia_jwt "$(rnd_pw 20)"
create_secret secrets/authelia_storage "$(rnd_pw 64)"
create_secret secrets/grafana_admin "$(rnd_pw 40)"
create_secret secrets/ldap_auth "$(rnd_pw 20)"
create_secret secrets/ldap_db "$(rnd_pw 20)"
create_secret secrets/nextcloud_admin "$(rnd_pw 40)"
create_secret secrets/nextcloud_db "$(rnd_pw 20)"
create_secret secrets/oidc_grafana "$(rnd_pw 40)"
create_secret secrets/protonmail_password_bridge "$(rnd_pw 20)"
create_secret secrets/teamspeak_db "$(rnd_pw 20)"

#
# Predefined secrets.
#
create_secret secrets/cloudflare "$(get_cloudflare_token)"
create_secret secrets/inadyn "$(cat <<-EOF
username=$(get_domain)
password=$(get_cloudflare_token)
hostname={$(get_domain)}
EOF
)"
create_secret secrets/protonmail_password "$(get_protonmail_password)"
create_secret secrets/protonmail_password_mailbox "$(get_protonmail_password_mailbox)"
