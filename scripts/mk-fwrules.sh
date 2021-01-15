#!/usr/bin/env bash

. ./scripts/util/fw.sh

add_service_fw syncthing
add_service_fw udpxy
add_service_fw iptv
add_fw --add-source=224.0.0.0/4

reload_fw
