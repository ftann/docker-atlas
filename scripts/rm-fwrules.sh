#!/usr/bin/env bash

. ./scripts/inc.sh

del_service_fw http
del_service_fw https
del_service_fw smtp
del_service_fw syncthing
del_service_fw teamspeak

reload_fw
