#!/usr/bin/env bash

set -euo pipefail

. /app/env.sh

file_env 'AWS_ACCESS_KEY_ID'
file_env 'AWS_SECRET_ACCESS_KEY'
file_env 'RESTIC_PASSWORD'

PREV=$(restic snapshots --compact | tail -4 | head -1 | awk '{print $1}')
LAST=$(restic snapshots --compact | tail -3 | head -1 | awk '{print $1}')

restic diff "${PREV}" "${LAST}"
