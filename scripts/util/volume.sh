#!/usr/bin/env bash

exists_volume() {
  [[ -d "$1" ]]
}

create_volume() {
  local volume="$1"
  if ! exists_volume "$volume"; then
    mkdir -p "$volume"
  fi
}

own_volume() {
  local volume="$1"
  if exists_volume "$volume"; then
    chown -R "$2:$3" "$volume"
  fi
}
