#!/usr/bin/env bash

offset_owner() {
  local path=$1
  local offset=$2
  while IFS= read -r -d "" f
  do
    uid="$(stat -c %u "${f}")"
    gid="$(stat -c %g "${f}")"
    ns_uid=$((uid + offset))
    ns_gid=$((gid + offset))
    echo chown "${ns_uid}:${ns_gid}" "${f}"
  done < <(find "${path}" -print0)
}

offset_owner "${1:-./}" "${2:-100000}"
