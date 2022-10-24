#!/usr/bin/env bash

set -euo pipefail

. /app/env.sh
. /app/file.sh
. /app/ldap.sh
. /app/placeholder.sh
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

if [[ ! -d "/config/databases/slapd.d/cn=config" ]]; then

  CONFIG_INIT=/tmp/openldap.ldif

  merge_files "/defaults/openldap/config/*.ldif" "${CONFIG_INIT}"

  replace_placeholder LDAP_BIND_USER "${LDAP_BIND_USER}" "${CONFIG_INIT}"
  replace_placeholder LDAP_BIND_PASSWORD "$(create_password_hash "${LDAP_BIND_PASSWORD}")" "${CONFIG_INIT}"
  replace_placeholder LDAP_CONFIG_PASSWORD "$(create_password_hash "${LDAP_CONFIG_PASSWORD}")" "${CONFIG_INIT}"
  # shellcheck disable=SC2046
  replace_placeholder LDAP_DOMAIN "${LDAP_DOMAIN}" "${CONFIG_INIT}"
  replace_placeholder LDAP_ROOT "${LDAP_ROOT}" "${CONFIG_INIT}"
  replace_placeholder LDAP_ROOT_PASSWORD "$(create_password_hash "${LDAP_ROOT_PASSWORD}")" "${CONFIG_INIT}"
  replace_placeholder PUID "$(id -u)" "${CONFIG_INIT}"
  replace_placeholder PGID "$(id -g)" "${CONFIG_INIT}"

  slapadd -d 0 -n 0 -F /config/databases/slapd.d -l "${CONFIG_INIT}"

  rm "${CONFIG_INIT}"
fi

if [[ ! -f /config/databases/openldap-data/data.mdb ]]; then

  DATABASE_INIT="/tmp/database.ldif"

  merge_files "/defaults/openldap/database/*.ldif" "${DATABASE_INIT}"

  replace_placeholder LDAP_BIND_USER "${LDAP_BIND_USER}" "${DATABASE_INIT}"
  replace_placeholder LDAP_BIND_PASSWORD "$(create_password_hash "${LDAP_BIND_PASSWORD}")" "${DATABASE_INIT}"
  replace_placeholder LDAP_DOMAIN "${LDAP_DOMAIN}" "${DATABASE_INIT}"
  replace_placeholder LDAP_ROOT "${LDAP_ROOT}" "${DATABASE_INIT}"
  replace_placeholder ORGANIZATION "$(get_organization "${LDAP_DOMAIN}")" "${DATABASE_INIT}"

  slapadd -d 0 -n 1 -F /config/databases/slapd.d -l "${DATABASE_INIT}"

  rm "${DATABASE_INIT}"

  if [[ -d /config/initdb.d ]]; then

    CUSTOM_INIT="/tmp/custom.ldif"

    merge_files "/config/initdb.d/*.ldif" "${CUSTOM_INIT}"

    slapd -d 0 -h "ldapi://%2Frun%2Fopenldap%2Fldapi" -F /config/databases/slapd.d &
    while [[ ! -e /run/openldap/slapd.pid ]]; do sleep 1; done

    ldapadd -c -Y EXTERNAL -Q -H "ldapi://%2Frun%2Fopenldap%2Fldapi" -f "${CUSTOM_INIT}" >/dev/null 2>&1

    PID="$(cat /run/openldap/slapd.pid)"
    kill -SIGTERM "${PID}"
    while [[ -e "/proc/${PID}" ]]; do sleep 1; done

    rm "${CUSTOM_INIT}"
  fi
fi
