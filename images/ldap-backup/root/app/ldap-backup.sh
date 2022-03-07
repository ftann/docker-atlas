#!/usr/bin/with-contenv bash

set -euo pipefail

. /opt/util/string.sh

# shellcheck disable=SC2046
LDAP_DOMAIN="$(join_by "," $(prepend_each "dc=" $(split "$DOMAIN")))"

LDAPTLS_REQCERT=never
export LDAPTLS_REQCERT

s6-setuidgid abc ldapsearch \
    -h "${LDAP_HOST}" -p "${LDAP_PORT}" \
    -D "${LDAP_BIND_USER}" -w "${LDAP_BIND_PASSWORD}" \
    -Z -LLL \
    -b "${LDAP_DOMAIN}" > /config/ldap/"${LDAP_NAME}".ldif
