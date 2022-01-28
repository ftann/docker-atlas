#!/usr/bin/env bash

. ./scripts/util/ask.sh
. ./scripts/util/root.sh
. ./scripts/util/run.sh

install() {
  check_root
  ./scripts/mk-fwrules.sh
  ./scripts/mk-networks.sh
  ./scripts/mk-secrets.sh
  ./scripts/mk-selinux.sh
}

up() {
  check_compose
  run_compose build --pull --parallel
  run_compose pull --include-deps
  run_compose up -d --remove-orphans
}

down() {
  run_compose down --remove-orphans
}

uninstall() {
  if ask; then
    run_compose down -v
    run_compose rm -v
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
