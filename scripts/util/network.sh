exists_network() {
  local network=$1
  docker network inspect "${network}" >/dev/null
}

create_network() {
  local network=$1
  if ! exists_network "${network}"; then
    docker network create --ipv6 \
      --subnet="$2" \
      --gateway="$3" \
      --subnet="$4" \
      --gateway="$5" \
      "${network}"
  fi
}

delete_network() {
  local network=$1
  if exists_network "${network}"; then
    docker network rm "${network}"
  fi
}
