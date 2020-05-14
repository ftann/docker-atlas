#!/usr/bin/env bash

. ./scripts/util/fw.sh

add_service_fw cockpit
add_service_fw ldaps
add_service_fw syncthing
add_service_fw udpxy

reload_fw
