#!/usr/bin/env bash

. ./scripts/util/ask.sh
. ./scripts/util/root.sh
. ./scripts/util/run.sh

install() {
  check_root
  ./scripts/mk-fwrules.sh
  ./scripts/mk-secrets.sh
  ./scripts/mk-selinux.sh
}

up() {
  docker compose build
  docker compose pull
  docker compose up -d --remove-orphans
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

status() {
  docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
}

run_if_defined "$@"
