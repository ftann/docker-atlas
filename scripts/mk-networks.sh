#!/usr/bin/env bash

. ./scripts/util/network.sh

create_network outside 192.168.200.0/24 192.168.0.1 fd00:d0ce::/64 fd00:d0ce::1
