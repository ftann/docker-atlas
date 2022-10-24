#!/usr/bin/env bash

. ./scripts/util/fw.sh

add_service_fw http
add_service_fw https
add_service_fw smtp
add_service_fw syncthing
add_service_fw teamspeak
add_service_fw udpxy

add_service_fw iptv
add_source_fw 224.0.0.0/4

reload_fw
