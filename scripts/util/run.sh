#!/usr/bin/env bash

. ./scripts/util/usage.sh

run_compose() {
  # Compatibility ensures that resource definitions are understood.
  docker-compose --compatibility "$@"
}

run_if_defined() {
  if declare -f "$1" >/dev/null; then
    "$@"
  else
    print_usage
    exit 1
  fi
}

check_compose() {
  run_compose config -q
}
