#!/usr/bin/env bash

. ./scripts/inc.sh

install() {
  check_root
  ./scripts/mk-fwrules.sh
  ./scripts/mk-secrets.sh
  ./scripts/mk-selinux.sh
  ./scripts/setup.sh
}

up() {
  docker compose up -d --build --remove-orphans
}

down() {
  docker compose down --remove-orphans
}

uninstall() {
  check_root
  if ask; then
    # Don't remove volumes and secrets!
    docker compose down --rmi all
    docker compose rm
    ./scripts/rm-fwrules.sh
  fi
}

clean() {
  if ask; then
    docker container prune
    docker image prune
    docker network prune
    docker volume prune
  fi
}

print_usage() {
  cat << EOF
usage: ctl COMMAND

Commands:

install     creates networks and firewall rules, volumes and secrets
up          builds and starts the containers
down        stops the containers
uninstall   stops and removes the containers
clean       removes unneeded containers, images, networks and volumes
EOF
}

run_if_defined() {
  if declare -f "$1" >/dev/null; then
    "$@"
  else
    print_usage
    exit 1
  fi
}

run_if_defined "$@"
