#!/usr/bin/env bash

set -euo pipefail

. /app/env.sh
. /app/tags.sh

file_env 'AWS_ACCESS_KEY_ID'
file_env 'AWS_SECRET_ACCESS_KEY'
file_env 'RESTIC_PASSWORD'

IFS=" " read -ra TAGS <<<"$(mk_tag_args "${RESTIC_BACKUP_TAGS}")"
restic backup --host "${RESTIC_BACKUP_HOST}" --iexclude-file=/config/restic/excludes "${TAGS[@]}" "${RESTIC_BACKUP_SOURCES}"

if [[ -n "${RESTIC_FORGET_ARGS}" ]]; then
  IFS=" " read -ra FORGET_ARGS <<<"${RESTIC_FORGET_ARGS}"
  restic forget "${TAGS[@]}" --prune --group-by "paths,tags" "${FORGET_ARGS[@]}"
fi
