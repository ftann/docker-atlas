#!/usr/bin/env bash

print_usage() {
  cat << EOF
usage: ctl COMMAND

Commands:

install     creates networks and firewall rules, volumes and secrets
up          builds and starts the containers
down        stops the containers
uninstall   stops and removes the containers
clean       removes unneeded containers, images, networks and volumes
status      displays current container status
EOF
}
