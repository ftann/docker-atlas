#!/usr/bin/env bash

set -euo pipefail

. /app/env.sh

file_env 'AWS_ACCESS_KEY_ID'
file_env 'AWS_SECRET_ACCESS_KEY'
file_env 'RESTIC_PASSWORD'

if ! restic cat config >/dev/null 2>&1; then
  restic init
fi

case $1 in
backup)
  /app/restic-backup.sh
  ;;
check)
  /app/restic-check.sh
  ;;
diff)
  /app/restic-diff-last.sh
  ;;
*)
  exec "$@"
  ;;
esac
