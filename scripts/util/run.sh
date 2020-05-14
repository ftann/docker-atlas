#!/usr/bin/env bash

run_compose() {
  # Compatibility ensures that resource definitions are understood.
  docker-compose --compatibility "$@"
}

run_if_defined() {
  if declare -f "$1" >/dev/null; then
    "$@"
  else
    exit 1
  fi
}
