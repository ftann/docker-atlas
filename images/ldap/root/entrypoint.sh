#!/usr/bin/env bash

set -euo pipefail

/app/init.sh

/usr/sbin/slapd \
   -h "ldap:/// ldaps:///" \
   -F /config/databases/slapd.d \
   -d 0
