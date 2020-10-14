#!/usr/bin/env bash

. ./scripts/util/ask.sh
. ./scripts/util/run.sh

install() {
  ./scripts/mk-fwrules.sh
  ./scripts/mk-networks.sh
  ./scripts/mk-secrets.sh
  ./scripts/mk-volumes.sh
  ./scripts/own-volumes.sh
  ./scripts/mk-selinux.sh
}

up() {
  ./scripts/mk-networks.sh
  run_compose build
  run_compose pull
  run_compose up -d
}

down() {
  run_compose down
}

remove() {
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
  docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"
}

run_if_defined "$@"
