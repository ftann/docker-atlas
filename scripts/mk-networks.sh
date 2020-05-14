#!/usr/bin/env bash

. ./scripts/util/network.sh

create_network ipv6 172.100.0.0/20 172.100.0.1 fd00:d0ce::/64 fd00:d0ce::1
