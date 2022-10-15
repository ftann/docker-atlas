#!/usr/bin/env bash

set -euo pipefail

. /app/env.sh
. /app/string.sh

file_env 'LDAP_BIND_PASSWORD'

# shellcheck disable=SC2046
LDAP_DOMAIN="$(join_by "," $(prepend_each "dc=" $(split "${DOMAIN}")))"

LDAPTLS_REQCERT=never
export LDAPTLS_REQCERT

ldapsearch \
    -H "ldap://localhost" \
    -D "cn=${LDAP_BIND_USER},${LDAP_DOMAIN}" -w "${LDAP_BIND_PASSWORD}" \
    -Z -b "${LDAP_DOMAIN}" \
    -LLL > "/config/backup/${DOMAIN}.ldif"
