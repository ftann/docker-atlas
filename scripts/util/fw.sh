#!/usr/bin/env bash

add_fw() {
  firewall-cmd --permanent "$@"
}

add_service_fw() {
  firewall-cmd --add-service="$1" --permanent
}

reload_fw() {
  firewall-cmd --reload
}
