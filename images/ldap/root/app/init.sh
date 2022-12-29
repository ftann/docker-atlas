#!/usr/bin/env bash

set -euo pipefail

. /app/env.sh
. /app/ldap.sh
. /app/string.sh

file_env 'LDAP_CONFIG_PASSWORD'
file_env 'LDAP_ROOT_PASSWORD'
file_env 'LDAP_BIND_PASSWORD'

if [[ ! -f /config/keys/cert.key || ! -f /config/keys/cert.crt ]]; then
  openssl req -new -x509 -days 3650 -nodes \
    -out /config/keys/cert.crt \
    -keyout /config/keys/cert.key \
    -subj "/C=US/ST=CA/L=Carlsbad/O=Linuxserver.io/OU=LSIO Server/CN=*"
fi

# shellcheck disable=SC2046
LDAP_DOMAIN="$(join_by "," $(prepend_each "dc=" $(split "${DOMAIN}")))"
LDAP_BIND_PASSWORD="$(create_password_hash "${LDAP_BIND_PASSWORD}")"
LDAP_CONFIG_PASSWORD="$(create_password_hash "${LDAP_CONFIG_PASSWORD}")"
LDAP_ROOT_PASSWORD="$(create_password_hash "${LDAP_ROOT_PASSWORD}")"
ORGANIZATION="$(get_organization "${LDAP_DOMAIN}")"
PUID="$(id -u)"
PGID="$(id -g)"

export LDAP_DOMAIN \
  LDAP_BIND_USER LDAP_BIND_PASSWORD \
  LDAP_CONFIG_PASSWORD \
  LDAP_ROOT LDAP_ROOT_PASSWORD \
  ORGANIZATION \
  PUID PGID

if [[ ! -d "/config/databases/slapd.d/cn=config" ]]; then
  CONFIG="$(mktemp)"
  envsubst < /defaults/openldap/config.ldif.tmpl > "${CONFIG}"
  slapadd -d 0 -n 0 -F /config/databases/slapd.d -l "${CONFIG}"
  rm "${CONFIG}"
fi

if [[ ! -f /config/databases/openldap-data/data.mdb ]]; then
  DATABASE="$(mktemp)"
  envsubst < /defaults/openldap/database.ldif.tmpl > "${DATABASE}"
  slapadd -d 0 -n 1 -F /config/databases/slapd.d -l "${DATABASE}"
  rm "${DATABASE}"

  if [[ -f /init.ldif ]]; then

    slapd -d 0 -h "ldapi://%2Frun%2Fopenldap%2Fldapi" -F /config/databases/slapd.d &
    while [[ ! -e /run/openldap/slapd.pid ]]; do sleep 1; done

    ldapadd -c -Y EXTERNAL -Q -H "ldapi://%2Frun%2Fopenldap%2Fldapi" -f /init.ldif >/dev/null 2>&1

    PID="$(cat /run/openldap/slapd.pid)"
    kill -SIGTERM "${PID}"
    while [[ -e "/proc/${PID}" ]]; do sleep 1; done
  fi
fi
