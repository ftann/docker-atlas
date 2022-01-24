#!/usr/bin/env bash

exists_network() {
  docker network inspect "$1" >/dev/null
}

create_network() {
  local network=$1
  if ! exists_network "$network"; then
    docker network create --ipv6 \
      --subnet="$2" \
      --gateway="$3" \
      --subnet="$4" \
      --gateway="$5" \
      "$network"
  fi
}
