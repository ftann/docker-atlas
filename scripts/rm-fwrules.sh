#!/usr/bin/env bash

. ./scripts/util/fw.sh

del_service_fw syncthing
del_service_fw teamspeak
del_service_fw udpxy

del_service_fw iptv
del_source_fw 224.0.0.0/4

reload_fw
