#!/usr/bin/env bash

. ./scripts/util/network.sh

create_network atlas_outside 192.168.200.0/24 192.168.200.1 fd00:d0ce::/64 fd00:d0ce::1
