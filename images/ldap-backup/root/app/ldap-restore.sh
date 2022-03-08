#!/usr/bin/with-contenv bash

set -euo pipefail

. /opt/util/string.sh

# shellcheck disable=SC2046
LDAP_DOMAIN="$(join_by "," $(prepend_each "dc=" $(split "$DOMAIN")))"

LDAPTLS_REQCERT=never
export LDAPTLS_REQCERT

s6-setuidgid abc ldapadd \
    -H "ldap://${LDAP_HOST}:${LDAP_PORT}" \
    -D "cn=${LDAP_BIND_USER},${LDAP_DOMAIN}" -w "${LDAP_BIND_PASSWORD}" \
    -Z -c \
    -b "${LDAP_DOMAIN}" -f /config/ldap/"${LDAP_NAME}".ldif
