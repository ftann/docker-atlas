#!/usr/bin/env bash

. ./scripts/inc.sh

add_service_fw http
add_service_fw https
add_service_fw smtp
add_service_fw syncthing
add_service_fw teamspeak

reload_fw
