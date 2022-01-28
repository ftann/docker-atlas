#!/usr/bin/env bash

add_fw() {
  firewall-cmd --permanent "$@"
}

add_service_fw() {
  add_fw --add-service="$1"
}

reload_fw() {
  firewall-cmd --reload
}
