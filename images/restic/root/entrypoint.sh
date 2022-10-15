#!/usr/bin/env bash

set -euo pipefail

. /app/env.sh

file_env 'AWS_ACCESS_KEY_ID'
file_env 'AWS_SECRET_ACCESS_KEY'
file_env 'RESTIC_PASSWORD'

if ! restic cat config >/dev/null 2>&1; then
  restic init
fi

if [[ "$1" == "backup" ]]; then
  /app/restic-backup.sh
elif [[ "$1" == "check" ]]; then
  /app/restic-check.sh
elif [[ "$1" == "diff" ]]; then
  /app/restic-diff-last.sh
else
  exit 1
fi
